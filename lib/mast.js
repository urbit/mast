let our;
let app;
let sub;
let subActId;
let eventSource;
let logMastDiffs = false;
let channelActId = 0;
const channelId = `${Date.now()}${Math.floor(Math.random() * 1000)}`;
const channelPath = `${window.location.origin}/~/channel/${channelId}`;
const clientState = {};
addEventListener('DOMContentLoaded', () => {
    our = document.documentElement.getAttribute('our');
    app = document.documentElement.getAttribute('app');
    sub = document.documentElement.getAttribute('sub');
    connectToShip();
    handleClientStateElements(document.body);
    handleClientAttrs(document.body);
    handleListeners(document.body);
    window.addEventListener("beforeunload", (e) => {
        sendActions([makeMastUnsubscribe()]);
    });
});
async function connectToShip() {
    await sendActions([makeMastSubscribe()]);
    eventSource = new EventSource(channelPath);
    eventSource.addEventListener('message', handleChannelStream);
};
function setEventListeners(el) {
    const eventAttrVals = el.getAttribute('event');
    if (eventAttrVals) {
        const returnAttrVals = el.getAttribute('return');
        const throttleMs = Number(el.getAttribute('throttle')) * 1000;
        const debounceMs = Number(el.getAttribute('debounce')) * 1000;
        eventAttrVals.split(/\s+/).forEach(eventAttr => {
            let splitEventAttr = eventAttr.split('/');
            if (splitEventAttr[0] === '') splitEventAttr.shift();
            const eventType = splitEventAttr[0];
            if (throttleMs) {
                el.addEventListener(
                    eventType,
                    pokeThrottle(throttleMs, eventType, eventAttr, returnAttrVals)
                );
            } else if (debounceMs) {
                el.addEventListener(
                    eventType,
                    pokeDebounce(debounceMs, eventType, eventAttr, returnAttrVals)
                );
            } else {
                el.addEventListener(eventType, (e) => {
                    pokeShip(e, e.currentTarget, eventType, eventAttr, returnAttrVals)
                });
            };
        });
    };
    const clientEventAttrVal = el.getAttribute('client-event');
    if (clientEventAttrVal) {
        const [eventType, key, val] = clientEventAttrVal.split(/\s+/);
        el.addEventListener(eventType, (e) => {
            clientState[key] = val;
            handleClientAttrs(document.body);
        });
    };
};
function handleListeners(el) {
    let needListeners =
        (el.hasAttribute('event') || el.hasAttribute('client-event'))
        ? [el, ...el.querySelectorAll('[event], [client-event]')]
        : [...el.querySelectorAll('[event], [client-event]')];
    needListeners.forEach(lEl => setEventListeners(lEl));
};
function handleClientAttrs(el) {
    let clientClassEls =
        el.matches('[client-class]')
        ? [el, ...el.querySelectorAll('[client-class]')]
        : [...el.querySelectorAll('[client-class]')];
    clientClassEls.forEach(cEl => {
        const clientClassAttr = cEl.getAttribute('client-class');
        const [attrKey, attrVal, aClass] = clientClassAttr.split(/\s+/);
        if (clientState.hasOwnProperty(attrKey)) {
            let flip = false;
            if (attrVal[0] === '!') {
                flip = true;
                attrVal = attrVal.slice(1);
            };
            const objVal = clientState[attrKey];
            if ((!flip && attrVal === objVal) || (flip && attrVal != objVal)) {
                cEl.classList.add(aClass);
            } else {
                cEl.classList.remove(aClass);
            };
        };
    });
    let clientDisplayEls =
        el.matches('[client-display]')
        ? [el, ...el.querySelectorAll('[client-display]')]
        : [...el.querySelectorAll('[client-display]')];
    clientDisplayEls.forEach(cEl => {
        const clientDisplayAttr = cEl.getAttribute('client-display');
        let [attrKey, attrVal] = clientDisplayAttr.split(/\s+/);
        if (clientState.hasOwnProperty(attrKey)) {
            let flip = false;
            if (attrVal[0] === '!') {
                flip = true;
                attrVal = attrVal.slice(1);
            };
            const objVal = clientState[attrKey];
            if ((!flip && attrVal === objVal) || (flip && attrVal != objVal)) {
                cEl.style.display = '';
            } else {
                cEl.style.display = 'none';
            };
        };
    });
};
function handleClientStateElements(el) {
    let cEls =
        (el.tagName === 'CLIENT-STATE')
        ? [el, ...el.getElementsByTagName('client-state')]
        : [...el.getElementsByTagName('client-state')];
    cEls.forEach(cEl => {
        for (let attr of cEl.attributes) {
            if (attr.name === 'key') continue;
            if (attr.name === 'style' && attr.value === 'display:none') continue;
            clientState[attr.name] = attr.value;
        };
    });
};
function pokeThrottle(ms, ...pokeArgs) {
    let ready = true;
    return (e) => {
        if (!ready) return;
        ready = false;
        window.setTimeout(() => { ready = true; }, ms);
        pokeShip(e, e.currentTarget, ...pokeArgs);
    };
};
function pokeDebounce(ms, ...pokeArgs) {
    let timeoutId = null;
    return (e) => {
        window.clearTimeout(timeoutId);
        timeoutId = window.setTimeout(() => pokeShip(e, e.target, ...pokeArgs), ms);
    };
};
function pokeShip(event, target, eventType, eventAttr, returnAttrVals) {
    const componentKey = target.closest('[mast]').getAttribute('key');
    let dat = {};
    if (returnAttrVals) {
        dat = handleReturnAttr(event, target, returnAttrVals);
    };
    if (eventType === 'submit') {
        event.preventDefault();
        const formData = new FormData(target);
        formData.forEach((v, k) => { dat[k] = v });
        target.reset();
    };
    sendActions([
        makePoke({
            com: componentKey,
            sub: sub,
            path: eventAttr,
            data: dat
        })
    ]);
};
function handleReturnAttr(event, target, returnAttrVals) {
    let returnData = {};
    returnAttrVals.split(/\s+/).forEach(returnAttr => {
        let splitReturnAttr = returnAttr.split('/');
        if (splitReturnAttr[0] === '') splitReturnAttr.shift();
        const returnObjSelector = splitReturnAttr[0];
        const key = splitReturnAttr[1];
        if (!returnObjSelector || !key) {
            console.error(`Malformed =return attribute: "${returnAttr}"`);
            return;
        }
        if (returnObjSelector === 'event') {
            if (!(key in event)) {
                console.error(`Property: ${key} does not exist on the event object`);
                return;
            };
            returnData[returnAttr] = String(event[key]);
        } else {
            let returnObj;
            if (returnObjSelector === 'target') {
                returnObj = target;
            } else {
                const linkedEl = document.getElementById(returnObjSelector);
                if (!linkedEl) {
                    console.error(`No element found for id: ${returnObjSelector}`);
                    return;
                };
                returnObj = linkedEl;
            };
            if (key.startsWith('data')) {
                const dataKey = key.substring(5).split('-').map((w, i) => {
                    if (i === 0) {
                        return w.toLowerCase();
                    } else {
                        return w.charAt(0).toUpperCase() + w.slice(1).toLowerCase();
                    };
                }).join('');
                if (!returnObj.dataset.hasOwnProperty(dataKey)) {
                    console.error(`Property: ${dataKey} does not exist on the specified object`);
                    return;
                };
                returnData[returnAttr] = String(returnObj.dataset[dataKey]);
            } else if (target.hasAttribute(key)) {
                returnData[returnAttr] = target.getAttribute(key)
            } else {
                if (!(key in returnObj)) {
                    console.error(`Property: ${key} does not exist on the specified object`);
                    return;
                };
                // TODO: handle other properties that don't cast to string
                returnData[returnAttr] = String(returnObj[key]);
            };
        };
    });
    return returnData;
};
async function handleChannelStream(event) {
    const msg = JSON.parse(event.data);
    sendActions([makeAck(msg.id)]);
    if (msg.response === 'quit') sendActions([makeMastSubscribe()]);
    if (msg.response !== 'diff') return;
    handleDiff(msg.json);
};
function handleDiff(diff) {
    if (logMastDiffs) console.log(diff);
    const comEl = document.querySelector(`[key="${diff.p}"]`);
    const oldCounter = Number(comEl.getAttribute('mast'));
    const newCounter = Number(diff.q);
    if (newCounter <= oldCounter) return;
    if (newCounter > (oldCounter + 1)) console.error('Applying out of sequece diff');
    comEl.setAttribute('mast', newCounter);
    diff.r.forEach(diffObj => {
        switch (diffObj.p) {
            case 'd':
                diffObj.q.forEach(key => {
                    let toRemove = document.querySelector(`[key="${key}"]`);
                    toRemove.remove();
                });
                break;
            case 'n':
                let parent = document.querySelector(`[key="${diffObj.q}"]`);
                if (diffObj.r === 0) {
                    parent.insertAdjacentHTML('afterbegin', diffObj.s);
                } else if (diffObj.r === parent.childNodes.length) {
                    parent.insertAdjacentHTML('beforeend', diffObj.s);
                } else {
                    let indexTarget = parent.childNodes[diffObj.r];
                    if (indexTarget.nodeType === 1) {
                        indexTarget.insertAdjacentHTML('beforebegin', diffObj.s);
                    } else {
                        let placeholder = document.createElement('div');
                        parent.insertBefore(placeholder, indexTarget);
                        placeholder = parent.childNodes[diffObj.r];
                        placeholder.outerHTML = diffObj.s;
                    };
                };
                let newNode = parent.childNodes[diffObj.r];
                if (newNode.nodeType === 1) {
                    handleListeners(newNode);
                    handleClientStateElements(newNode);
                };
                break;
            case 'm':
                let fromNode = document.querySelector(`[key="${diffObj.q}"]`);
                const fromIndex = [ ...fromNode.parentNode.childNodes ].indexOf(fromNode);
                if (fromIndex < diffObj.r) diffObj.r++;
                let toNode = fromNode.parentNode.childNodes[diffObj.r];
                fromNode.parentNode.insertBefore(fromNode, toNode);
                break;
            case 'c':
                let eventsChanged = false;
                let targetNode = document.querySelector(`[key="${diffObj.q}"]`);
                diffObj.r.forEach(name => {
                    if (name === 'event' || name === 'client-event') eventsChanged = true;
                    targetNode.removeAttribute(name);
                });
                diffObj.s.forEach(attr => {
                    const name = attr[0];
                    const value = attr[1];
                    if (name === 'event' || name === 'client-event') eventsChanged = true;
                    targetNode.setAttribute(name, value);
                });
                if (eventsChanged) {
                    // shallow clone to remove previous event handlers
                    let clone = targetNode.cloneNode(false);
                    while (targetNode.firstChild) {
                      clone.appendChild(targetNode.firstChild);
                    };
                    setEventListeners(clone);
                    targetNode.replaceWith(clone);
                };
                if (targetNode.tagName === 'CLIENT-STATE') handleClientStateElements(targetNode);
                break;
            case 't':
                let textWrapperNode = document.querySelector(`[key="${diffObj.q}"]`);
                textWrapperNode.textContent = diffObj.r;
                break;
        };
    });
    handleClientAttrs(document.body)
};
function sendActions(actArray) {
    fetch(channelPath, {
        method: 'PUT',
        body: JSON.stringify(actArray)
    });
};
function makeMastSubscribe() {
    channelActId++;
    subActId = channelActId;
    return {
        id: channelActId,
        action: 'subscribe',
        ship: our,
        app: app,
        path: sub
    };
};
function makeMastUnsubscribe() {
    channelActId++;
    return {
        id: channelActId,
        action: 'unsubscribe',
        subscription: subActId
    };
};
function makePoke(jsonData) {
    channelActId++;
    return {
        id: channelActId,
        action: 'poke',
        ship: our,
        app: app,
        mark: 'json',
        json: ['mast', jsonData]
    };
};
function makeAck(eventId) {
    channelActId++;
    return {
        id: channelActId,
        action: 'ack',
        "event-id": eventId
    };
};

