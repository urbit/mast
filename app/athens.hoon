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
  =/  old  (mole |.(!<(state-n vase)))
  =?  state  ?=(^ old)  u.old
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
      ?+  care  ~
        %r
          :^  ~  ~  %$  !>
          [%athens-access !>(access.state)]
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
++  handle-mast-poke
  |=  [=mark =vase]
  ^+  cor
  ?.  ?=(%mast-poke mark)  (poke mark vase)
  ?>  =(/gall/mast sap.bowl)
  =/  tid  !<  tide:mast  vase
  =.  src.bowl  src.tid
  %-  poke  dat.tid
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
        %patch-post 
      %+  patch-post  post-at.act  content.act
      ::
        %del-post
      %-  del-post  at.act
      ::
        %access-public
      %-  access-public  public.act
      ::
        %edit-access-id
      %-  edit-access-id  ids.act
      ::
        %del-access-id
      %-  del-access-id  id.act
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
  %+  make-fact-card  (weld /r/posts post-at)  ~
::
++  patch-post 
  |=  [post-at=path dat=@t]
  ^+  cor 
  =.  posts
    |-  ^-  posts:athens
    ?~  post-at  posts
    =/  id  (slav %da i.post-at)
    =/  [poz=post:athens rez=posts:athens]  (~(got by posts) id)
    %+  ~(put by posts)  id
    :_  rez
    :-  author.poz
        dat
  %-  emit
  %+  make-fact-card  (weld /r/posts post-at)  ~
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
  %+  make-fact-card  (weld /t/posts (snip at))  ~
::
++  access-public
  |=  public=?
  ^+  cor
  ~&  access
  ?:  =(public public.access)  cor
  =.  access  [public ~]
  %-  emit
  %+  make-fact-card  /t/posts  `access
::
++  edit-access-id
  |=  ids=(list @p)
  ^+  cor
  =.  access  :-  public.access 
              (welp ids.access ids)
  %-  emit
  %+  make-fact-card  /t/posts  `access
::
++  del-access-id
  |=  id=@p
  ^+  cor
  =/  index-id  (find [id]~ ids.access)
  ?~  index-id  cor
  =.  access  :-  public.access
              (oust [(need index-id) 1] ids.access)
  %-  emit
  %+  make-fact-card  /t/posts  `access
::
++  get-post-key-paths
  |=  poz=posts:athens
  ^-  (list path)
  %+  turn  (sort ~(tap in ~(key by poz)) lte)
  |=  k=post-id:athens
  /[(scot %da k)]
::
++  make-fact-card
  |=  [=path uacc=(unit access:athens)]
  ^-  card
  ?:  =(~ uacc)
    :*  %give  %fact  ~[path]  %athens-access  !>(access.state)
    ==
  :*  %give  %fact  ~[path]  %athens-access  !>((need uacc))
  ==
::
--

