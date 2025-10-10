/+  mast
|%
+$  action
  $%  [%test ~]
  ==
+$  state-0
  $:  *
  ==
+$  state-n
  $%  [%state-0 state-0]
  ==
+$  card  card:agent:gall
--
::
%-  mast
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
  =^  cards  state  abet:init:cor
  :-  cards  this
::
++  on-save
  ^-  vase
  =<  save  cor
::
++  on-load
  |=  =vase
  ^-  (quip card _this)
  =^  cards  state  abet:(load:cor vase)
  :-  cards  this
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
  :-  ~  this
::
++  on-leave
  |=  =path
  ^-  (quip card _this)
  :-  ~  this
::
++  on-peek
  |=  =path
  ^*  (unit (unit cage))
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  :-  ~  this
::
++  on-arvo
  |=  [=wire sign=sign-arvo]
  ^-  (quip card _this)
  =^  cards  state  abet:(arvo:cor wire sign)
  :-  cards  this
::
++  on-fail
  |=  [=term =tang]
  ^-  (quip card _this)
  :-  ~  this
--
::
|_  [=bowl:gall cards=(list card)]
++  cor   .
++  abet  :-  (flop cards)  state
++  emit  |=  =card  cor(cards [card cards])
++  emil  |=  caz=(list card)  cor(cards (welp (flop caz) cards))
::
++  init
  ^+  cor
  cor
::
++  save
  ^-  vase
  !>  ~
::
++  load
  |=  vaz=vase
  ^+  cor
  init
::
++  arvo
  |=  [wir=(pole @ta) sin=sign-arvo]
  ^+  cor
  cor
::
++  poke
  |=  [=mark =vase]
  ^+  cor
  ?+  mark  ~|(bad-poke/mark !!) 
    ::
      %example-action
    =/  act  !<  action  vase
    ?-  -.act
      ::
        %test
      cor
      ::
    ==
    ::
  == 
::
--

