/+  mast
::
|%
+$  posts  ((mop @da @t) gth)
+$  state
  $:  =posts
  ==
+$  card  card:agent:gall
--
::
=|  state
=*  state  -
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: 
:: %mast is an agent wrapper.
:: use ++wrap:mast to wrap your gall agent along with a component map.
:: your gall agent and your components must be built under equivalent contexts,
:: so anything that you want to pin to the subject should precede ++wrap:mast.
%+  wrap:mast
  %-  malt
  ^-  dock:mast
  :~  :: this is the root component core.
      :: component cores get added to your map tagged with their name.
      :: there must be a root component identified by the null tag %$.
      :-  %$
      :: the sample of a component consists of +$stay which supplies context like the bowl,
      :: +$sack which contains any props passed down to the component from a parent,
      :: and +$stow which is your component's local state.
      |_  [=stay:mast =sack:mast =stow:mast]
      ++  scud  ~
      ::
      ++  spar
        |=  =crow:mast
        ^-  [blow:mast stow:mast]
        [~^~ stow]
      ::
      :: the ++sail arm is where you render your component.
      ++  sail
        ^-  manx
        :: the root component's sail must be a complete document.
        ;html
          ;head
            ;meta(charset "utf-8");
          ==
          ;body
            :: make:mast lets you create a component element to link your component core.
            :: components render independently;
            :: ++make:mast does not directly render a nested component's sail.
            ;+  (make:mast %post-form "post-form" ~)
            ;+  (make:mast %post-list "post-list" ~)
          ==
        ==
      --
      ::
      :-  %post-form
      |_  [=stay:mast =sack:mast =stow:mast]
      ++  scud  ~
      ::
      ++  spar
        :: the ++spar arm is where you handle UI events.
        :: as a result of an event, you can produce an effect for %mast,
        :: including a poke to forward to your gall agent, or a URL change.
        :: and you may also update local component state.
        |=  =crow:mast
        ^-  [blow:mast stow:mast]
        ?>  ?=(%poke -.crow)
        ?+  path.crow  [~^~ stow]
          ::
          :: this case matches the path specified in a sail element's event attribute.
            [%submit %post-form ~]
          :: data.crow contains any form data (or other specified data)
          :: returned from the client on the event.
          :: 'post-input' is the name of the input element in the form.
          =/  txt  (~(got by data.crow) 'post-input')
          :_  stow
          :-  ~
          :: this is a poke to forward to the gall agent.
          `[%add-post !>(txt)]
          ::
        ==
      ::
      ++  sail
        ^-  manx
        :: the event attribute here corresponds to the case in the ++spar handler above.
        ;form(event "/submit/post-form")
          ;input(name "post-input");
          ;button: post
        ==
      --
      ::
      :-  %post-list
      |_  [=stay:mast =sack:mast =stow:mast]
      :: the ++scud arm is where you declare which parts of the subject a component reacts to.
      :: it produces a (unit noun).
      :: if the unit is null, %mast will not treat this component as reactive on the subject.
      :: otherwise, if the value changes %mast will rerender the component.
      ++  scud
        `posts
      ::
      ++  spar
        |=  =crow:mast
        ^-  [blow:mast stow:mast]
        [~^~ stow]
      ::
      ++  sail
        :: the sail arm can produce regular manx,
        :: but if you want to pass down arbitrary nouns to nested components,
        :: you need to use hoot mode by adding the %hoot tag.
        :: this will change the product to manx:hoot.
        :-  %hoot
        ^-  manx:hoot
        ;div
          ;*  %+  turn  (tap:((on @da @t) gth) posts)
              |=  [id=@da txt=@t]
              :: when in hoot mode, you can use ++make-hoot:mast to link components
              :: and pass down props in a list of vases tagged with prop names.
              :: when props passed down to an existing component change,
              :: the component will rerender.
              %:  make-hoot:mast  %post  <id>
                :-  %id   !>  id
                :-  %txt  !>  txt
                ~
              ==
        ==
      --
      ::
      :-  %post
      |_  [=stay:mast =sack:mast $~(!>(|) =stow:mast)]
      ++  scud  ~
      ::
      ++  spar
        |=  =crow:mast
        ^-  [blow:mast stow:mast]
        ?>  ?=(%poke -.crow)
        ?+  path.crow  [~^~ stow]
          ::
            [%click %hide ~]
          :: this event handler pins the component's local state,
          :: and then produces a change to the local state.
          :: when local state changes, the component will rerender.
          =/  hidden  !<  ?  stow
          :-  ~^~  !>(!hidden)
          ::
            [%click %delete ~]
          =/  id  !<  @da  (~(got by sack) %id)
          :_  stow
          :-  ~
          `[%delete-post !>(id)]
          ::
        ==
      ::
      ++  sail
        ^-  manx
        :: id and txt are pinned with values from the props map.
        :: these props were passed down when rendering the %post component inside %post-list.
        =/  id  !<  @da  (~(got by sack) %id)
        =/  txt  !<  @t  (~(got by sack) %txt)
        =/  hidden  !<  ?  stow
        ;div
          ;h2: {<id>}
          ;p: {?.(hidden (trip txt) "")}
          ;button(event "/click/hide"): hide
          ;button(event "/click/delete"): delete
        ==
      --
      ::
  ==
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: 
:: your gall agent is the second part of the ++wrap:mast sample.
:: your gall agent can be written normally;
:: the entire UI exists separately in the components above,
:: simply changing in reaction to your gall agent's state.
^-  agent:gall
|_  =bowl:gall
+*  this  .
++  on-init
  ^-  (quip card _this)
  :_  this
  :~  (bind-url:mast dap.bowl /mast-demo)
  ==
++  on-save
  ^-  vase
  !>  ~
++  on-load
  |=  =vase
  ^-  (quip card _this)
  :_  this(state *^state)
  :~  (bind-url:mast dap.bowl /mast-demo)
  ==
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: 
++  on-poke
  |=  [=mark =vase]
  ?+  mark  ~|(bad-poke/mark !!) 
    ::
      %add-post
    =/  txt  !<  @t  vase
    =.  posts  (put:((on @da @t) gth) posts now.bowl txt)
    [~ this]
    ::
      %delete-post
    =/  id  !<  @da  vase
    =.  posts  +:(del:((on @da @t) gth) posts id)
    [~ this]
    ::
  ==
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: 
++  on-watch  |=(path ^-((quip card _this) `this))
++  on-leave  |=(path ^-((quip card _this) !!))
++  on-peek   |=(path ^-((unit (unit cage)) !!))
++  on-agent  |=([wire sign:agent:gall] ^-((quip card _this) !!))
++  on-arvo   |=([wire sign-arvo] ^-((quip card _this) !!))
++  on-fail   |=([term tang] ^-((quip card _this) !!))
--

