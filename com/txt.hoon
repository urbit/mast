/-  mast
::
=/  info-card
  ::
  |=  [=path =cage]
  ^-  card:agent:gall
  =/  =soba:clay  [path %ins cage]~
  =/  =nori:clay  [%& soba] 
  =/  =task:clay  [%info %base nori]
  [%pass mast-ins/path %arvo %c task]
  ::
:-  ^-  boom:mast
    :*  %txt
        %x
        !>(*flag)
    ==
^-  mast:mast
|_  [=scud:mast =sack:mast]
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ?+  -.crow  ~^~
    ::
      [%click %poll ~]
    :-  ~  !>
    ?:(!<(flag loc.sack) | &)
  ::
    ::
      [%submit %save ~]
    =/  txt  (~(got by data.crow) 'txt')
    =/  wain  (to-wain:format txt)
    :_  loc.sack
    :~  (info-card pax.scud %txt !>(wain))
    ==
    ::
  ==
::
++  sail
  ^-  manx
  =/  fil  !<  wain  fil.sack
  =/  txt  (trip (of-wain:format fil))
  |^
    ;form.grow.fc.spring.b1
      =event  "/submit/save"
      ;textarea#txt-edit.grow.scroll-x.p2.pre.mono.s-1
        =name  "txt"
        =spellcheck  "false"
        =value  txt
        ;-  txt
      ==
      ;button.br1.bd1.b2.hover.p2: save
      ;script
        ::  watch textarea for changes and update accordingly
        ;-  %-  trip
        '''
        let targetElement = document.getElementById('txt-edit');
        const observer = new MutationObserver((mutationsList) => {
          for (const mutation of mutationsList) {
            if (
              mutation.type === 'attributes' &&
              mutation.attributeName === 'value'
            ) {
              const newValue = targetElement.getAttribute('value');
              targetElement.innerHTML = newValue;
            }
          }
        });
        observer.observe(targetElement, {
          attributes: true,
          attributeFilter: ['value']
        });
        // inital
        targetElement.innerHTML = targetElement.getAttribute('value');
        '''
      ==
    ==
  --
::
--
