let our;
let src;
let eventSource;
let subscription;
let subMessageId;
let logMastDiffs = false;
let channelMessageId = 0;
const channelId = `${Date.now()}${Math.floor(Math.random() * 1000)}`;
const channelPath = `${window.location.origin}/~/channel/${channelId}`;
const clientState = {};
addEventListener('DOMContentLoaded', async () => {
    our = document.documentElement.getAttribute('our');
    src = document.documentElement.getAttribute('src');
    subscription = `/${src}${document.body.querySelector('[mast]').getAttribute('mast')}`
    handleClientStateElements(document.body);
    handleClientAttrs(document.body);
    await connectToShip();
    let eventElements = document.body.querySelectorAll('[event], [client-event]');
    eventElements.forEach(el => setEventListeners(el));
    window.addEventListener('beforeunload', () => closeSubscription());
});
async function connectToShip() {
    await fetch(channelPath, { 
        method: 'PUT',
        body: JSON.stringify(makeSubscribeBody())
    });
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
        (el.tagName === 'CLIENT:STATE')
        ? [el, ...el.getElementsByTagName('client:state')]
        : [...el.getElementsByTagName('client:state')];
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
    const componentAttr = target.closest('[mast]').getAttribute('mast');
    let uiEventData = {};
    if (returnAttrVals) {
        uiEventData = handleReturnAttr(event, target, returnAttrVals);
    };
    if (eventType === 'submit') {
        event.preventDefault();
        const formData = new FormData(target);
        formData.forEach((v, k) => { uiEventData[k] = v });
        target.reset();
    };
    fetch(channelPath, {
        method: 'PUT',
        body: JSON.stringify(makePokeBody({
            com: componentAttr,
            path: eventAttr,
            data: uiEventData
        }))
    });
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
function handleChannelStream(event) {
    const streamResponse = JSON.parse(event.data);
    fetch(channelPath, {
        method: 'PUT',
        body: JSON.stringify(makeAck(streamResponse.id))
    });
    if (streamResponse.response === 'quit') {
        fetch(channelPath, { 
            method: 'PUT',
            body: JSON.stringify(makeSubscribeBody())
        });
    }
    if (streamResponse.response !== 'diff') return;
    if (logMastDiffs) console.log(streamResponse);
    streamResponse.json.forEach(gustObj => {
        switch (gustObj.p) {
            case 'd':
                gustObj.q.forEach(key => {
                    let toRemove = document.querySelector(`[key="${key}"]`);
                    toRemove.remove();
                });
                break;
            case 'n':
                let parent = document.querySelector(`[key="${gustObj.q}"]`);
                if (gustObj.r === 0) {
                    parent.insertAdjacentHTML('afterbegin', gustObj.s);
                } else if (gustObj.r === parent.childNodes.length) {
                    parent.insertAdjacentHTML('beforeend', gustObj.s);
                } else {
                    let indexTarget = parent.childNodes[gustObj.r];
                    if (indexTarget.nodeType === 1) {
                        indexTarget.insertAdjacentHTML('beforebegin', gustObj.s);
                    } else {
                        let placeholder = document.createElement('div');
                        parent.insertBefore(placeholder, indexTarget);
                        placeholder = parent.childNodes[gustObj.r];
                        placeholder.outerHTML = gustObj.s;
                    };
                };
                let newNode = parent.childNodes[gustObj.r];
                if (newNode.nodeType === 1) {
                    let needListeners =
                        (newNode.getAttribute('event') || newNode.getAttribute('client-event'))
                        ? [newNode, ...newNode.querySelectorAll('[event], [client-event]')]
                        : [...newNode.querySelectorAll('[event], [client-event]')];
                    needListeners.forEach(el => setEventListeners(el));
                    handleClientStateElements(newNode);
                    handleClientAttrs(newNode);
                };
                break;
            case 'm':
                let fromNode = document.querySelector(`[key="${gustObj.q}"]`);
                const fromIndex = [ ...fromNode.parentNode.childNodes ].indexOf(fromNode);
                if (fromIndex < gustObj.r) gustObj.r++;
                let toNode = fromNode.parentNode.childNodes[gustObj.r];
                fromNode.parentNode.insertBefore(fromNode, toNode);
                break;
            case 'c':
                let targetNode = document.querySelector(`[key="${gustObj.q}"]`);
                let eventsHaveChanged = false;
                gustObj.r.forEach(attr => {
                    if (attr === 'event' || attr === 'client-event') {
                        eventsHaveChanged = true;
                    };
                    targetNode.removeAttribute(attr);
                });
                gustObj.s.forEach(attr => {
                    const name = attr[0];
                    const value = attr[1];
                    targetNode.setAttribute(name, value);
                    if (name === 'event' || attr === 'client-event') {
                        eventsHaveChanged = true;
                    };
                });
                if (eventsHaveChanged) {
                    // shallow clone to remove previous event handlers
                    let clone = targetNode.cloneNode(false);
                    while (targetNode.firstChild) {
                      clone.appendChild(targetNode.firstChild);
                    };
                    setEventListeners(clone);
                    targetNode.replaceWith(clone);
                };
                break;
            case 't':
                let textWrapperNode = document.querySelector(`[key="${gustObj.q}"]`);
                textWrapperNode.textContent = gustObj.r;
                break;
        };
    });
};
function closeSubscription() {
    channelMessageId++;
    fetch(channelPath, {
        method: 'PUT',
        body: JSON.stringify([{
            id: channelMessageId,
            action: 'unsubscribe',
            subscription: subMessageId
        }])
    });
};
function makeSubscribeBody() {
    channelMessageId++;
    subMessageId = channelMessageId;
    return [{
        id: channelMessageId,
        action: 'subscribe',
        ship: our,
        app: 'mast',
        path: subscription
    }];
};
function makePokeBody(jsonData) {
    channelMessageId++;
    return [{
        id: channelMessageId,
        action: 'poke',
        ship: our,
        app: 'mast',
        mark: 'json',
        json: ['mast', jsonData]
    }];
};
function makeAck(eventId) {
    channelMessageId++;
    return [{
        id: channelMessageId,
        action: 'ack',
        "event-id": eventId
    }];
};

