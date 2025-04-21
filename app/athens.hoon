/-  *athens
|%
+$  card  card:agent:gall
+$  state-0
  $:  =posts
      =user-sessions
  ==
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
  ~&  >  %init
  ~&  >  %sky-bowl
  ~&  >>  sky.bowl
  :-  ~  this
::
++  on-save
  ^-  vase
  !>  ~
::
++  on-load
  |=  =vase
  ^-  (quip card _this)
  ~&  >  %load
  ~&  >  %sky-bowl
  ~&  >>  sky.bowl
  :-  ~  this
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
  ~&  [%on-watch path]
  :-  ~  this
::
++  on-leave  |=(path ^-((quip card _this) !!))
++  on-peek   |=(path ^-((unit (unit cage)) !!))
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
      %delete-all
    =/  fans-on  ((on @ud (pair @da (each page @uvI))) lte)
    %-  emil
    %-  ~(rep by sky.bowl)
    |=  [[k=path v=fans:gall] a=(list card)]
    =/  fan  (pry:fans-on v)
    ?~  fan  a
    :_  a
    :*  [%pass /delete %cull ud+key.u.fan k]
    ==
    ::
      %test-post
    =/  dat  !<  @t  vase
    %-  add-post  dat
    ::
      %test-check
    ~&  >>  sky.bowl
    cor
    ::
  == 
::
++  add-post
  |=  dat=@t
  ^+  cor
  =/  =post  [src.bowl dat]
  =/  =post-id  now.bowl
  =.  posts  (~(put by posts) post-id post)
  %-  emil
  %+  grow-post  post-id  post
::
++  grow-post
  |=  [=post-id =post]
  ^-  (list card)
  =/  post-path  (make-post-path post-id)
  :~  (make-grow-card post-path athens-post/post)
      (make-fact-card post-path)
  ==
::
++  make-post-path
  |=  =post-id
  /posts/[(scot %da post-id)]
::
++  make-grow-card
  |=  [=path =page]
  ^-  card
  :*  %pass  /grow  %grow  path  page
  ==
::
++  make-fact-card
  |=  =path
  ^-  card
  :*  %give  %fact  ~[path]  %noun  !>(~)
  ==
::
--

