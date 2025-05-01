/-  athens
|%
+$  card  card:agent:gall
+$  state-0  state:athens
+$  state-n
  $%  [%state-0 state-0]
  ==
--
::
=|  state-n
=*  state  -
=<
^-  agent:gall
|_  =bowl:gall
+*  this  .
    cor  ~(. +> [bowl ~])
::
++  on-init
  ^-  (quip card _this)
  :_  this
  ~
::
++  on-save
  ^-  vase
  !>  ~
::
++  on-load
  |=  =vase
  ^-  (quip card _this)
  :_  this
  ~
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  =^  cards  state  abet:(poke:cor mark vase)
  :-  cards  this
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ~&  [%athens-watch path]
  :-  ~  this
::
++  on-leave  |=(path ^-((quip card _this) !!))
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ~&  [%athens-peek path]
  ?+  path  !!
    ::
      [%r %athens ~]
    :^  ~  ~  %$  !>
    [%athens !>(+.state)]
    ::
      [%t %athens ~]
    :^  ~  ~  %$  !>
    *(list ^path)
    ::
  ==
::
++  on-agent  |=([wire sign:agent:gall] ^-((quip card _this) !!))
++  on-arvo   |=([wire sign-arvo] ^-((quip card _this) !!))
++  on-fail   |=([term tang] ^-((quip card _this) !!))
--
::
|_  [=bowl:gall cards=(list card)]
++  cor   .
++  abet  :-  (flop cards)  state
++  emit  |=  =card  cor(cards [card cards])
++  emil  |=  caz=(list card)  cor(cards (welp (flop caz) cards))
::
++  poke
  |=  [=mark =vase]
  ^+  cor
  ?+  mark  ~|(bad-poke/mark !!) 
    ::
      %test-post
    =/  dat  !<  @t  vase
    %-  add-post  dat
    ::
  == 
::
++  add-post
  |=  dat=@t
  ^+  cor
  =/  =post:athens  [src.bowl dat ~]
  =/  =post-id:athens  now.bowl
  =.  posts  (~(put by posts) post-id post)
  %-  emit
  %-  make-fact-card  /r/athens  :: NOTE: fact update path here
::
++  make-fact-card
  |=  =path
  ^-  card
  :*  %give  %fact  ~[path]  %noun  !>(~)
  ==
::
--

