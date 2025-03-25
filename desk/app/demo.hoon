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
%+  wrap:mast
  %-  malt
  ^-  dock:mast
  :~  :-  %$
      |_  [=stay:mast =sack:mast =stow:mast]
      ++  scud  ~
      ::
      ++  spar
        |=  =crow:mast
        ^-  [blow:mast stow:mast]
        [~^~ stow]
      ::
      ++  sail
        ^-  manx
        ;html
          ;head
            ;meta(charset "utf-8");
          ==
          ;body
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
        |=  =crow:mast
        ^-  [blow:mast stow:mast]
        ?>  ?=(%poke -.crow)
        ?+  path.crow  [~^~ stow]
          ::
            [%submit %post-form ~]
          =/  txt  (~(got by data.crow) 'post-input')
          :_  stow
          :-  ~
          `[%add-post !>(txt)]
          ::
        ==
      ::
      ++  sail
        ^-  manx
        ;form(event "/submit/post-form")
          ;input(name "post-input");
          ;button: post
        ==
      --
      ::
      :-  %post-list
      |_  [=stay:mast =sack:mast =stow:mast]
      ++  scud
        `posts
      ::
      ++  spar
        |=  =crow:mast
        ^-  [blow:mast stow:mast]
        [~^~ stow]
      ::
      ++  sail
        :-  %hoot
        ^-  manx:hoot
        ;div
          ;*  %+  turn  (tap:((on @da @t) gth) posts)
              |=  [id=@da txt=@t]
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

