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
  :-  ~  this
::
++  on-leave  |=(path ^-((quip card _this) !!))
::
++  on-peek
  |=  pax=path
  ^-  (unit (unit cage))
  ?<  ?=(~ pax)
  =/  care  i.pax
  =/  pole  ^-  (pole @ta)  t.pax
  ?+  pole  ~
    ::
    [%posts ~]
      ?+  care  ~
        %r
          :^  ~  ~  %$  !>
          [%noun !>(~)]
        %t
          :^  ~  ~  %$  !>
          (get-post-key-paths posts)
      ==
    ::
    [%posts rest=^]
      |-  ^-  (unit (unit cage))
      =/  =post-id:athens  (slav %da -.rest.pole)
      =/  =post-node:athens  (~(got by posts) post-id)
      ?^  +.rest.pole  $(posts replies.post-node, rest.pole +.rest.pole)
      ?+  care  ~
        %r
          :^  ~  ~  %$  !>
          [%athens-post !>(post.post-node)]
        %t
          :^  ~  ~  %$  !>
          (get-post-key-paths replies.post-node)
      ==
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
      %athens-action
    =/  act  !<  action:athens  vase
    ?-  -.act
      ::
        %put-post
      %+  put-post  post-at.act  content.act
      ::
    ==
    ::
  == 
::
++  put-post
  |=  [post-at=path dat=@t]
  ^+  cor
  =/  new-post=post:athens  [src.bowl dat]
  =/  new-id=post-id:athens  now.bowl
  =.  posts
    |-  ^-  posts:athens
    ?~  post-at  (~(put by posts) new-id [new-post ~])
    =/  id  (slav %da i.post-at)
    =/  [poz=post:athens rez=posts:athens]  (~(got by posts) id)
    %+  ~(put by posts)  id
    :-  poz
    %=  $
      post-at  t.post-at
      posts  rez
    ==
  %-  emit
  %-  make-fact-card  (weld /t/posts post-at)
::
++  get-post-key-paths
  |=  poz=posts:athens
  ^-  (list path)
  %+  turn  (sort ~(tap in ~(key by poz)) lte)
  |=  k=post-id:athens
  /[(scot %da k)]
::
++  make-fact-card
  |=  =path
  ^-  card
  :*  %give  %fact  ~[path]  %noun  !>(~)
  ==
::
--

