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
          [%athens !>([access.state (get-session src.bowl)])]
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
      ~&  >>  %access-public
      %-  access-public  public.act
      ::
        %edit-access-id
      %-  edit-access-id  ids.act
      ::
        %del-access-id
      %-  del-access-id  id.act
      ::
        %hide-post
      %-  hide-post  post.act
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
  %+  make-fact-card  (weld /r/posts post-at)  src.bowl
::
++  patch-post 
  |=  [patch-at=path dat=@t]
  ^+  cor 
  =.  posts
    |-  ^-  posts:athens
    ?~  patch-at  !!
    =/  id  (slav %da i.patch-at)
    =/  [poz=post:athens rez=posts:athens]  (~(got by posts) id)
    ?~  t.patch-at
      ?>  =(author.poz src.bowl)
      %+  ~(put by posts)  id
      :_  rez
      :-  author.poz
          dat
    %+  ~(put by posts)  id
    :-  poz
    %=  $
      patch-at  t.patch-at
      posts  rez
    ==
  %-  emit
  %+  make-fact-card  (weld /r/posts patch-at)  src.bowl
::
++  del-post
  |=  at=path
  ^+  cor
  ?~  at  !!
  =/  id  (slav %da i.at)
  =.  posts
    |-  ^-  posts:athens
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
  =/  user-session  (get-session src.bowl)
  =/  upd-user-session=user-session:athens
    :-  read-posts.user-session
        (~(del in hidden-posts.user-session) id)
  =.  user-sessions
    %:  ~(put by user-sessions) 
        src.bowl
        upd-user-session
    ==
  %-  emit
  %+  make-fact-card-updstate  (weld /t/posts (snip `path`at))  
  :-  access.state
      upd-user-session
::
++  access-public
  |=  public=?
  ^+  cor
  ?.  =(src.bowl our.bowl)  cor
  =/  user-session  (get-session our.bowl)
  ?:  =(public public.access)  cor
  =.  access  :*  public 
                  members.access
                  blacklist.access
              ==
  %-  emit
  %+  make-fact-card-updstate  /t/posts  access^user-session
::
++  edit-access-id
  |=  ids=(list @p)
  ^+  cor
  ?.  =(src.bowl our.bowl)  cor
  =/  user-session  (get-session our.bowl)
  ?.  public.access
    =.  members.access  (welp members.access ids)
    %-  emit
    %+  make-fact-card-updstate  /t/posts  access^user-session
  =.  blacklist.access  (welp blacklist.access ids)
  %-  emit
  %+  make-fact-card-updstate  /t/posts  access^user-session
::
++  del-access-id
  |=  id=@p
  ^+  cor
  ?.  =(src.bowl our.bowl)  cor
  =/  user-session  (get-session our.bowl)
  =/  index-id  %+  find  [id]~ 
                ?.  public.access
                  members.access
                blacklist.access
  ?~  index-id  cor
  ?.  public.access
    =.  members.access  (oust [(need index-id) 1] members.access)
    %-  emit
    %+  make-fact-card-updstate  /t/posts  access^user-session
  =.  blacklist.access  (oust [(need index-id) 1] blacklist.access)
  %-  emit
  %+  make-fact-card-updstate  /t/posts  access^user-session
::
++  hide-post 
  |=  post=post-id:athens
  ^+  cor
  =/  index-id  %+  find  [src.bowl]~ 
                ?.  public.access
                  members.access
                blacklist.access
  ?.  |(=(~ index-id) !=(our.bowl src.bowl))  cor
  ::  TODO:  if post already hidden remove from set
  =/  user-session  (~(get by user-sessions) src.bowl)
  ?~  user-session
    =/  us  [*(set post-id:athens) (silt ~[post])]
    =.  user-sessions  (~(put by user-sessions) src.bowl us)
    %-  emit  
    %+  make-fact-card-updstate  /t/posts  access.state^us
  =.  user-sessions  
    %:  ~(put by user-sessions) 
        src.bowl
        :-  read-posts:(need user-session)
        `(set post-id:athens)`(~(put in hidden-posts:(need user-session)) post)
    ==
  ~&  >  `(set post-id:athens)`(~(put in hidden-posts:(need user-session)) post)
  %-  emit  
  %+  make-fact-card-updstate  /t/posts  
  :-  access.state
  :-  read-posts:(need user-session)
      `(set post-id:athens)`(~(put in hidden-posts:(need user-session)) post)
::
++  get-post-key-paths
  |=  poz=posts:athens
  ^-  (list path)
  %+  turn  (sort ~(tap in ~(key by poz)) lte)
  |=  k=post-id:athens
  /[(scot %da k)]
::
++  make-fact-card
  |=  [=path src=@p]
  ^-  card
  =/  user-session  (~(get by user-sessions.state) src)
  ?~  user-session
    :*  %give  %fact  ~[path]  %athens  !>([access.state *user-session:athens])
    ==
  :*  %give  %fact  ~[path]  %athens  !>([access.state (need user-session)])
  ==
::
++  make-fact-card-updstate
  |=  [=path updstate=[access:athens user-session:athens]]
  ^-  card
  :*  %give  %fact  ~[path]  %athens  !>(updstate)
  ==
::
++  get-session  
|=  patp=@p
^-  user-session:athens
=/  u-user-session  (~(get by user-sessions) patp)
?~  u-user-session  *user-session:athens
  (need u-user-session)
--

