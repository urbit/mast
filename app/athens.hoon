/-  athens, mast
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
  :-  ~  this
::
++  on-save
  ^-  vase
  !>  state
::
++  on-load
  |=  =vase
  ^-  (quip card _this)
  :-  ~  this
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  =^  cards  state  abet:(handle-mast-poke:cor mark vase)
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
      :^  ~  ~  %$  !>
      [%athens-post-list !>((get-post-key-paths posts))]
    ::
    [%posts rest=^]
      |-  ^-  (unit (unit cage))
      =/  =post-id:athens  (slav %da -.rest.pole)
      =/  =post-node:athens  (~(got by posts) post-id)
      ?^  +.rest.pole
        %=  $
          posts  replies.post-node
          rest.pole  +.rest.pole
        ==
      :^  ~  ~  %$  !>
      [%athens-post !>([post.post-node (get-post-key-paths replies.post-node)])]
    ::
    [%hidden who=@ta id=@ta ~]
      =/  usr  (~(get by user-sessions) (slav %p who.pole))
      =/  hid
        ^-  ?
        ?~  usr  |
        %-  ~(has in hidden-posts.u.usr)  (slav %da id.pole)
      :^  ~  ~  %$  !>
      ~&  >>>  hid
      [%noun !>(hid)]
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
++  handle-mast-poke
  |=  [=mark =vase]
  ^+  cor
  ?.  ?=(%mast-poke mark)  (poke mark vase)
  ?>  =(/gall/mast sap.bowl)
  =/  gul  !<  gull:mast  vase
  =.  src.bowl  src.gul
  %-  poke  dat.gul
::
++  poke
  |=  [=mark =vase]
  ^+  cor
  ?+  mark  ~|(bad-poke/mark !!) 
    ::
      %athens-action
    ?:  ?=(%pawn (clan:title src.bowl))  !!
    =/  act  !<  action:athens  vase
    ?-  -.act
      ::
        %put-post
      %+  put-post  post-at.act  content.act
      ::
        %del-post
      %-  del-post  at.act
      ::
        %hide-post
      %-  hide-post  id.act
      ::
        %unhide-post
      %-  unhide-post  id.act
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
  %-  make-fact-card  (weld /r/posts post-at)
::
++  del-post
  |=  at=path
  ^+  cor
  =.  posts
    |-  ^-  posts:athens
    ?~  at  !!
    =/  id  (slav %da i.at)
    =/  [poz=post:athens rez=posts:athens]  (~(got by posts) id)
    ?~  t.at
      ?>  ?|  =(author.poz src.bowl)
              =(src.bowl our.bowl)
          ==
      %-  ~(del by posts)  id
    %+  ~(put by posts)  id
    :-  poz
    %=  $
      at  t.at
      posts  rez
    ==
  %-  emit
  %-  make-fact-card  (weld /r/posts (snip at))
::
++  hide-post
  |=  id=post-id:athens
  ^+  cor
  =/  usr  (~(get by user-sessions) src.bowl)
  ~&  >>  user-sessions
  =.  user-sessions
    ?~  usr
      =|  new=user-session:athens
      =.  hidden-posts.new  (~(put in hidden-posts.new) id)
      %+  ~(put by user-sessions)  src.bowl  new
    =.  hidden-posts.u.usr  (~(put in hidden-posts.u.usr) id)
    %+  ~(put by user-sessions)  src.bowl  u.usr
  ~&  >  user-sessions
  %-  emit
  %-  make-fact-card  /r/hidden/[(scot %p src.bowl)]/[(scot %da id)]
::
++  unhide-post
  |=  id=post-id:athens
  ^+  cor
  =/  usr  (~(got by user-sessions) src.bowl)
  =.  hidden-posts.usr  (~(del in hidden-posts.usr) id)
  ~&  >>  user-sessions
  =.  user-sessions  (~(put by user-sessions) src.bowl usr)
  ~&  >  user-sessions
  %-  emit
  %-  make-fact-card  /r/hidden/[(scot %p src.bowl)]/[(scot %da id)]
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

