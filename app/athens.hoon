/-  athens
/+  mast
/*  favicon  %png  /fil/favicon/png
/*  app-tile  %png  /fil/app-tile/png
|%
+$  card  card:agent:gall
+$  state-1
  $:  %state-1
      =posts:athens
      =user-sessions:athens
      access=access:athens
  ==
--
::
%-  mast
=|  state-1
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
  |=  ole=vase
  :: handle a load that removes the mast wrapper:
  =?  ole  ?=([%mast *] +.ole)  =>(!<([%mast * v=vase] ole) v)
  |^
    ^-  (quip card _this)
    =/  old  (mole |.(!<(state-n ole)))
    ~?  ?=(~ old)  '!!!! STATE RESETTING. SOMETHING WENT WRONG !!!!'
    ::
    =?  state  ?=(^ old)
      ?-  -.u.old
        %state-1  u.old
        %state-0  (state-0-to-1 u.old)
      ==
    :_  this
    :~
      :*  %pass  /bind  %arvo  %e  %connect  [~ /athens]  %athens
      ==
    ==
  +$  state-n
    $%  state-0
        state-1
    ==
  +$  state-0
    $:  %state-0
        =posts:athens
        =user-sessions-0:athens
        =access-0:athens
    ==
  ++  state-0-to-1
    |=  zero=state-0
    ^-  state-1
    :*  %state-1
        posts.zero
        ::
        ^-  user-sessions:athens
        %-  malt
        %+  turn  ~(tap by user-sessions-0.zero)
        |=  [=ship s=user-session-0:athens]
        :-  ship
        ^-  user-session:athens
        :+  hidden-posts.s
          new-posts.s
        ~
        ::
        %*  .  *access:athens
          mode  ?:(public.access-0.zero %public %private)
          blacklist  blacklist.access-0.zero
          members  members.access-0.zero
        ==
    ==
  --
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
++  on-leave  |=(path ^*((quip card _this)))
::
++  on-peek
  |=  pax=path
  ^-  (unit (unit cage))
  ?<  ?=(~ pax)
  =/  care  i.pax
  =/  pole  ^-  (pole @ta)  t.pax
  ?+  pole  ~
    ::
    [%posts-all ~]
      :+  ~  ~
      [%athens-post-list !>((get-post-key-paths posts))]
    ::
    [%posts rest=^]
      =/  =post-node:athens  (get-post-node rest.pole posts)
      =/  rep-num  (count-replies replies.post-node)
      :+  ~  ~
      [%athens-post !>([[post.post-node rep-num] (get-post-key-paths replies.post-node)])]
    ::
    [%view who=@ta rest=^]
      =/  who  (slav %p who.pole)
      ?.  =(who src.bowl)  ~
      =/  usr  (~(get by user-sessions) who)
      :+  ~  ~
      [%noun !>((get-view rest.pole usr posts now.bowl))]
    ::
    [%new who=@ta rest=^]
      =/  who  (slav %p who.pole)
      ?.  =(who src.bowl)  ~
      =/  usr  (~(get by user-sessions) who)
      ?~  usr  :+  ~  ~  [%noun !>(~)]
      =/  new-posts  (get-sort-posts new-posts.u.usr rest.pole)
      ?:  ?&  =((tail rest.pole) /)
              =(%hidden -:(get-view rest.pole usr posts now.bowl))
          ==
        =/  siblings  ~(tap in (hidden-siblings-below (slav %da (rear rest.pole)) (get-post-key-id posts) hidden-posts.u.usr))
        =/  new-posts
          %-  zing
          %+  turn  siblings 
          |=  i=post-id:athens
          =/  sib-path  /[(scot %da i)]
          (get-sort-posts new-posts.u.usr sib-path)
        :+  ~  ~  [%noun !>(new-posts)]
      :+  ~  ~  [%noun !>(new-posts)]
    ::
    [%access ~]
      :+  ~  ~
      [%athens-access !>(access)]
    ::
  ==
::
++  on-agent  |=([wire sign:agent:gall] *(quip card _this))
++  on-arvo   |=([wire sign-arvo] *(quip card _this))
++  on-fail
  |=  [=term =tang]
  ^-  (quip card _this)
  %-  (slog term tang)
  `this
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
  =;  =(each _cor tang)
    ?:  ?=([%.y *] each)  p.each
    %-  (slog %poke-failed p.each)
    cor
  %-  mule  |.
  ?+  mark  ~|(bad-poke/mark !!) 
    ::
      %handle-http-request
    %-  handle-http-request
    !<  [rid=@ta req=inbound-request:eyre]  vase
    ::
      %athens-action
    =/  act  !<  action:athens  vase
    ?-  -.act
        %gated-set-door-code
      %-  set-door-code  code.act
      ::
        %gated-sign-in
      %+  gated-sign-in  comet.act  id.act
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
        %hide-post
      %-  hide-post  at.act
      ::
        %hide-all  
      %-  hide-all  bundles.act
      ::
        %unhide-post
      %-  unhide-post  at.act
      ::
        %unhide-bundles
      %+  unhide-bundles  dat.act  at.act
      ::
        %set-user-position
      %-  set-user-position  at.act
      ::
        %set-access-mode
      %-  set-access-mode  mode.act
      ::
        %edit-access-id
      %-  edit-access-id  ids.act
      ::
        %del-access-id
      %-  del-access-id  id.act
      ::
    ==
    ::
  == 
::
++  user  (~(gut by accounts.access) src.bowl src.bowl)
::
++  put-post
  |=  [post-at=path dat=@t]
  ^+  cor
  =/  new-post=post:athens
    :-  user  :: use fingerprint if available
    dat
  =/  new-id=post-id:athens  now.bowl
  =.  user-sessions
    ?~  post-at  user-sessions
    `user-sessions:athens`(~(run by user-sessions) ~(to-new add-post [new-id post-at]))
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
  %-  emil
  ?~  post-at 
      :~  %-  make-fact-card  /x/posts-all
      ==
  ::  handles updating view if post hidden in bundle of replies or bundled by date
  =/  cards
    %-  zing
    %+  murn  ~(tap in ~(key by user-sessions))
    |=  ship=@p
    ?:  =(ship user)  ~
    =/  usr  (~(got by user-sessions) ship)
    =/  top-lvl  =(1 (lent post-at))
    =/  replies
      ?:  top-lvl  posts
      replies:(get-post-node ;;(path (snip `(list @tas)`post-at)) posts)
    =/  sibling-wrapper=post-id:athens
      %-  bundle-wrapper 
      :*  (slav %da (rear post-at))
          replies
          hidden-posts.usr
          ?:(top-lvl `now.bowl ~)
      ==
    =/  view-card
      %-  make-fact-card 
      ;;  path
      %-  zing  
      :~  /x/view/[(scot %p ship)] 
          ;;(path (snip `(list @tas)`post-at)) 
          /[(scot %da sibling-wrapper)]
      ==
    ?:  top-lvl
      :-  ~
      :~  view-card
      ==
    =/  wrapper-bundle=post-id:athens
      %-  bundle-wrapper 
      :*  (slav %da (head post-at))
          posts
          hidden-posts.usr
          `now.bowl
      ==
    ?:  =(sibling-wrapper (slav %da (rear post-at))) 
      :-  ~
      :~  %-  make-fact-card 
          /x/view/[(scot %p ship)]/[(scot %da wrapper-bundle)]
      ==
    :-  ~
    :~  view-card
        %-  make-fact-card 
        /x/view/[(scot %p ship)]/[(scot %da wrapper-bundle)]
    ==
  =/  at=path  post-at
  |-  ^-  (list card)
  ?:  =(/ (tail at))
    (snoc `(list card)`cards (make-fact-card (weld /x/posts `(list @ta)`at)))
  =/  c  (snoc `(list card)`cards (make-fact-card (weld /x/posts `(list @ta)`at)))
  %=  $
    at   (snip `path`at)
    cards  c
  ==
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
      ?>  =(author.poz user)
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
  %-  make-fact-card  (weld /x/posts patch-at)
::
++  del-post
  |=  at=path
  ^+  cor
  =/  user  user
  =.  posts
    |-  ^-  posts:athens
    ?~  at  !!
    =/  id  (slav %da i.at)
    =/  [poz=post:athens rez=posts:athens]  (~(got by posts) id)
    ?~  t.at
      ?>  ?|  =(author.poz user)
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
  ?:  =(1 (lent at))
    %-  make-fact-card  /x/posts-all
  %-  make-fact-card  (weld /x/posts (snip at))
::
++  hide-post
  |=  at=path
  ^+  cor
  =/  user  user
  =/  usr  (~(get by user-sessions) user)
  =/  id  (slav %da (rear at))
  =/  hidden-posts
    ?~  usr 
      (~(put in *(set post-id:athens)) id)
    (~(put in hidden-posts.u.usr) id)
  =.  user-sessions
    ?~  usr
      =|  new=user-session:athens
      =.  hidden-posts.new  hidden-posts
      %+  ~(put by user-sessions)  user  new
    =/  new-rep=(list path)
      %-  homo
      %+  skip  ~(tap in new-posts.u.usr)
      |=(=path =(~ (find at path)))
    =.  hidden-posts.u.usr  hidden-posts
    =.  new-posts.u.usr
      (~(dif in new-posts.u.usr) (silt new-rep)) 
    %+  ~(put by user-sessions)  user  u.usr
  ?.  =(/ (tail at)) 
    =/  replies  replies:(get-post-node `path`(snip `(list @ta)`at) posts)
    =/  card-to  (hidden-siblings id replies hidden-posts)
    %-  emil 
    %+  turn  ~(tap in card-to)
    |=  i=post-id:athens
    %-  make-fact-card  (weld /x/view/[(scot %p user)] (weld (snip at) /[(scot %da i)]))
  =/  poz-id  (get-post-key-id posts)
  =/  index  
    =/  u-i  (find ~[id] poz-id)
    ?~  u-i  !!
    (need u-i)
  =/  sibling-id
    ?:  (gte index 1)
      ?:  (gte (lent poz-id) +(index))
        (swag [(dec index) 3] poz-id)
      (swag [(dec index) 2] poz-id)
    (swag [index 2] poz-id)
  =/  card-to
    %+  skip  sibling-id
    |=  =post-id:athens
    =(~ (find ~[post-id] ~(tap in hidden-posts)))
  %-  emil 
  %+  turn  card-to
  |=  i=post-id:athens
  %-  make-fact-card  (weld /x/view/[(scot %p user)] (weld (snip at) /[(scot %da i)]))
::
++  hide-all
  |=  bundles=(list @da)
  ^+  cor 
  =/  user  user
  =/  u-usr  (~(get by user-sessions) user)
  |^
  =/  posts-id  posts-to-id
  =/  usr
    ?~  u-usr  *user-session:athens  (need u-usr)
  =/  open-post-ids=(set post-id:athens)  
    (~(dif in (silt posts-id)) hidden-posts.usr)
  =/  open-post-paths=(set path)
    %-  %~  run  in 
        open-post-ids
      |=  p=post-id:athens  (find-path p ~(tap in new-posts.usr))
  =.  user-sessions  
    %+  ~(put by user-sessions)  user 
    ?~  u-usr  [(silt posts-id) *(set path) ~]
    =/  hide-new-posts=(set path)  (~(int in open-post-paths) new-posts.usr)
    :*  (silt posts-id) 
      (~(dif in new-posts.usr) hide-new-posts)
      selected-post.usr
    ==
  %-  emil  
  %+  turn  (weld bundles ~(tap in open-post-ids))
  |=  at=post-id:athens
  %-  make-fact-card  /x/view/[(scot %p user)]/[(scot %da at)]
  ::
  ++  posts-to-id
    ^-  (list post-id:athens)
    =/  all-posts  posts
    =/  ids=(list post-id:athens)  ~
    |-  ^-  (list post-id:athens)
    ?:  =(~ all-posts)  ids
    =/  get-posts
      %-  ~(rep by all-posts)
      |=  [p=[i=post-id:athens node=post-node:athens] q=[i=(list post-id:athens) p=posts:athens]]
      :-  (snoc i.q i.p)
      `posts:athens`(~(uni by p.q) replies.node.p) 
    %=  $
      ids  (weld ids i.q.get-posts)
      all-posts  p.q.get-posts
    ==
  ::
  ++  find-path
  |=  [id=post-id:athens new-posts=(list path)]
  ^-  path
  =/  post-path=(list path)
    %+  skim  new-posts
    |=  p=path
    =(id (slav %da (rear p)))
  ?~  post-path  ~
  -.post-path
--
::
++  unhide-post
  |=  at=path
  ^+  cor
  =/  user  user
  =/  usr  (~(got by user-sessions) user)
  =/  id  (slav %da (rear at))
  =/  new-posts  (get-sort-posts new-posts.usr at)
  |^
  =/  parent-post  parent-data
  ?~  new-posts
    ?.  =(/ (tail at)) 
      =.  hidden-posts.usr  -.parent-post
      =.  user-sessions  (~(put by user-sessions) user usr)
      %-  emil  +.parent-post
    =.  hidden-posts.usr 
      (~(del in hidden-posts.usr) id)
    =.  user-sessions  (~(put by user-sessions) user usr)
    %-  emit
    %-  make-fact-card  (weld /x/view/[(scot %p user)] at)
  =/  new-posts-id  
    %-  silt
    ;;  (list @da)
    %-  zing
    %+  turn  new-posts
    |=  p=path
    %+  turn  p  |=(id=@ta (slav %da id))
  =.  hidden-posts.usr
    %-  %~  dif  in 
        hidden-posts.usr
      (~(uni in (~(put in new-posts-id) id)) -.parent-post)
  =.  user-sessions  (~(put by user-sessions) user usr)
  %-  emil
  =/  cards  *(list card)
  =/  at=path  (rear new-posts)
  |-  ^-  (list card)
  ?:  =(~ at)
    %+  weld  +.parent-post
    (flop cards)
  =/  c  (snoc `(list card)`cards (make-fact-card (weld /x/view/[(scot %p user)] `(list @ta)`at)))
  %=  $
    at   (snip `path`at)
    cards  c
  ==
  ++  parent-data
    ^-  [(set post-id:athens) (list card)]
    ?:  =(/ (tail at))  [*(set post-id:athens) ~]
    =/  replies  replies:(get-post-node `path`(snip `(list @ta)`at) posts)
    =/  unhide  (hidden-siblings-below id (get-post-key-id replies) hidden-posts.usr)
    :-
      %-  %~  dif  in 
      hidden-posts.usr
      unhide
    %+  turn  ~(tap in unhide)
    |=  id=post-id:athens
    %-  make-fact-card  (weld /x/view/[(scot %p user)] (weld (snip at) /[(scot %da id)]))
--
++  unhide-bundles
  |=  [dat=date-type:athens at=path]
  ^+  cor
  =/  user  user
  =/  usr  (~(got by user-sessions) user)
  =/  post-id  (slav %da (rear at))
  =/  posts-id=(list post-id:athens)
    ::  new to old
    %-  sort  :_  lth
    %+  turn  ~(tap by posts)
    |=  [id=post-id:athens *]  id
  =/  id-list  (id-list-by-date post-id now.bowl posts-id)
  =/  unhide=(list post-id:athens)
    %~  tap  in
      (~(int in hidden-posts.usr) (silt id-list))
  =.  hidden-posts.usr  (~(dif in hidden-posts.usr) (silt unhide))
  =.  user-sessions  (~(put by user-sessions) user usr)
  %-  emil
  %+  turn  unhide 
  |=  id=post-id:athens
  %-  make-fact-card  /x/view/[(scot %p user)]/[(scot %da id)]
::
++  set-door-code
  |=  code=@t
  ^+  cor
  =.  door-code.access  code
  %-  emit
  %-  make-fact-card  /x/access
  ::
++  gated-sign-in
  |=  [comet=@p id=@p]
  ^+  cor
  =.  accounts.access  (~(put by accounts.access) comet id)
  %-  emit
  %-  make-fact-card  /x/access
::
++  set-user-position
  |=  at=path
  ^+  cor
  =/  usr  (~(get by user-sessions) user)
  =/  already-selected
    ?~  usr  |
    ?~  selected-post.u.usr  |
    ?:  =(u.selected-post.u.usr at)  &  |
  ?:  already-selected  cor
  =/  old-selected-card  
    ?~  usr  ~  
    ?~  selected-post.u.usr  ~
    :~ 
      %-  make-fact-card  (weld /x/view/[(scot %p user)] u.selected-post.u.usr)
    ==
  =.  user-sessions  
    ?~  usr
      =|  new=user-session:athens
      =.  selected-post.new  `at
      %+  ~(put by user-sessions)  user  new
    =.  selected-post.u.usr  `at
    %+  ~(put by user-sessions)  user  u.usr
  %-  emil
  %+  weld  
  :~
    %-  make-fact-card  (weld /x/view/[(scot %p user)] at)
  ==
  old-selected-card
::
++  set-access-mode
  |=  =term
  ^+  cor
  =.  mode.access  (access-mode:athens term)
  %-  emit
  %-  make-fact-card  /x/access
::
++  edit-access-id
  |=  ids=(list @p)  ::  xx why is this a list?
  ^+  cor
  ?-  mode.access
    %gated  cor
    %private
      ?^  (find ids members.access)  cor
      =.  members.access  (welp ids members.access)
      %-  emit
      %-  make-fact-card  /x/access
    %public
      ?^  (find ids blacklist.access)  cor
      =.  blacklist.access  (welp ids blacklist.access)
      %-  emit
      %-  make-fact-card  /x/access
  ==
::
++  del-access-id
  |=  id=@p
  ^+  cor
  ?-  mode.access
    %gated  cor
    %private
      =/  index-id  (find [id]~ members.access)
      ?~  index-id  cor
      =.  members.access  (oust [(need index-id) 1] members.access)
      %-  emit
      %-  make-fact-card  /x/access
    %public
      =/  index-id  (find [id]~ blacklist.access)
      ?~  index-id  cor
      =.  blacklist.access  (oust [(need index-id) 1] blacklist.access)
      %-  emit
      %-  make-fact-card  /x/access
  ==
::
++  get-post-key-paths
  |=  poz=posts:athens
  ^-  (list path)
  %+  turn  (get-post-key-id poz)
  |=  k=post-id:athens
  /[(scot %da k)]
::
++  get-post-key-id
  |=  poz=posts:athens
  (sort ~(tap in ~(key by poz)) lte)
::
++  get-view
  |=  [post-path=path usr=(unit user-session:athens) =posts:athens now=@da]
  ^-  view:athens
  =/  id=post-id:athens  (slav %da (rear post-path))
  ?~  usr  [%old |]
  =/  selected-post=path  
    ?~  selected-post.u.usr  ~  
    u.selected-post.u.usr
  ?.  (~(has in hidden-posts.u.usr) id)
    ?.  (~(has in new-posts.u.usr) post-path)  
      :-  %old
      =(post-path selected-post)
    :-  %new
    =(post-path selected-post)
  =/  hidden-view=view:athens
    :*  %hidden
      0
      %-  lent  %-  homo
      %+  skip  ~(tap in new-posts.u.usr)
      |=  p=path
      =(~ (find ~[(rear post-path)] p))
      =(post-path selected-post)
    ==
  ?.  =(/ (tail post-path)) 
    =/  replies  replies:(get-post-node `path`(snip `(list @ta)`post-path) posts)
    =/  id-list=(list post-id:athens)  
      (sort ~(tap in ~(key by replies)) lte)
    ::  index of item in posts
    =/  i  (find ~[(slav %da (rear post-path))] id-list)
    ?:  
      ?&  !=(i ~)
          (gth (lent id-list) +((need i)))
          (~(has in hidden-posts.u.usr) (snag +((need i)) id-list))
      ==
        [%display-none ~]
    ?:  
      ?&  (gte (need i) 1)
          (~(has in hidden-posts.u.usr) (snag (dec (need i)) id-list))
      ==
    ::if post above is hidden 
      =/  siblings   ~(tap in (hidden-siblings-below id (get-post-key-id replies) hidden-posts.u.usr))
      =/  num-new=@ud
        %-  reel  :_  add
        %+  turn  siblings 
        |=  i=post-id:athens
        =/  sib-path  /[(scot %da i)]
        %-  lent  %-  homo
        %+  skip  ~(tap in new-posts.u.usr)
        |=  p=path
        =(~ (find ~[(rear sib-path)] p))
      =/  num  (lent siblings)
      `view:athens`[%hidden [num num-new =(post-path selected-post)]]
    hidden-view
  =/  hidden-old-view  (collapsed-by-date id posts now usr)
  ?~  hidden-old-view  
    hidden-view
  u.hidden-old-view
::
++  collapsed-by-date
  |=  [when=@da posts=posts:athens now=@da usr=(unit user-session:athens)]
  ^-  (unit view:athens)
  =/  d  (sub d:(yell now) d:(yell when))  
  =/  yor-now  (yore now)
  =/  yor-when  (yore when)
  =/  poz-id=(list post-id:athens)
    %-  sort  :_  lth
    %+  turn  ~(tap by posts)
    |=  [id=post-id:athens *]  id
  =/  poz  (id-list-by-date when now poz-id)
  =/  dat
    ?:  (gte d 365)
    %year
    ?:  &((gte d 30) (lth d 365))
    %month
    ?.  (gte d 7)  %day  %week
  ::  checks sibling view in feed
  ?:  =(dat %day)  ~
  =/  u-i  %+  find  ~[when]  poz
  ?~  u-i  ~
  =/  index  (need u-i)
  ?~  usr  ~
  ?:  ?&  (gth (lent poz) +(index))
          (~(has in hidden-posts.u.usr) (snag +(index) poz))
      ==
    `[%display-none ~]
  ?:  ?&  (gte index 1)
          (~(has in hidden-posts.u.usr) (snag (dec index) poz))
      ==
    =/  siblings   ~(tap in (hidden-siblings-below when poz hidden-posts.u.usr))
    =/  num-new=@ud
      %-  reel  :_  add
      %+  turn  siblings
      |=  i=post-id:athens
      =/  sib-path  /[(scot %da i)]
      %-  lent  %-  homo
      %+  skip  ~(tap in new-posts.u.usr)
      |=  p=path
      =(~ (find sib-path p))
    =/  num  (lent siblings)
    `[%hid-old dat num num-new -.poz]
  :-  ~
  :*  %hid-old
      dat
      0
      %-  lent  %-  homo
      %+  skip  ~(tap in new-posts.u.usr)
      |=  p=path
      =(~ (find ~[(scot %da when)] p))
      -.poz
    ==
::
++  count-replies
  |=  replies=posts:athens
  =/  counter  0
  |-  ^-  @
  ?:  =(~ replies)  counter
  =/  rep-counter
    %-  ~(rep by replies)
    |=  [p=[@ node=post-node:athens] q=[p=posts:athens n=@]]
    :-  `posts:athens`(~(uni by p.q) replies.node.p) 
    +(n.q)
  %=  $
    replies  p.q.rep-counter
    counter  (add counter n.q.rep-counter)
  ==
::  returns: post-id for siblings wrapper 
++  bundle-wrapper
  |=  [id=post-id:athens poz=posts:athens hidden-posts=(set post-id:athens) now=(unit @da)]
  ^-  post-id:athens
  =/  poz-list=(list post-id:athens)  
    (sort ~(tap in ~(key by poz)) lte)
  =/  id-list  
    ?:  =(~ now)  poz-list
    (id-list-by-date id (need now) poz-list)
  =/  u-ix  (find ~[id] id-list)
  ?~  u-ix  id
  =/  ix  (need u-ix)
  |-  ^-  post-id:athens
  ::  if below is hidden
  ?:  ?&  (gth (lent id-list) +(ix))
          (~(has in hidden-posts) (snag +(ix) id-list))
      ==
    =/  next  (snag +(ix) id-list)
    ?:  ?&  (gth (lent id-list) (add 2 ix))
            (~(has in hidden-posts) (snag (add 2 ix) id-list))
        ==
      %=  $
      ix  +(ix)
      ==
    next
  id
::
++  id-list-by-date
  |=  [when=post-id:athens now=@da poz-id=(list post-id:athens)]
  ^-  (list post-id:athens)
  =/  yor-now  (yore now)
  =/  yor-when  (yore when)
  =/  d  (sub d:(yell now) d:(yell when))  
  ?:  (gte d 365)
    =/  y  (sub y:-:yor-now y:-:yor-when)
    %-  sort  :_  lth
    %+  skim  poz-id
    |=  id=post-id:athens
    =/  d-post  (sub d:(yell now) d:(yell id))  
    =/  yor-post  (yore id)
    &(=(y (sub y:-:yor-now y:-:yor-post)) (gte d-post 365))
  ?:  &((gte d 30) (lth d 365))
      ::  amount of months ago 
    =/  m  
      ?:  =(y:-:yor-now y:-:yor-when)
        (sub m:yor-now m:yor-when)
      (sub (add m:yor-now 12) m:yor-when)
    %-  sort  :_  lth
    %+  skim  poz-id
    |=  id=post-id:athens
    =/  d-post  (sub d:(yell now) d:(yell id)) 
    =/  yor-post  (yore id)
    ?.  &((gte d 30) (lth d 365))  |
    ?:  &((gth m:yor-post m:yor-now) =(+(y.-.yor-post) y.-.yor-now))
      =(m (sub (add m:yor-now 12) m:yor-post))
    =(m (sub m:yor-now m:yor-post))
  ?.  (gte d 7)  ~  ::%days
  =/  w  (div d 7)
  %-  sort  :_  lth
  %+  skim  poz-id
  |=  id=post-id:athens
  =/  w-post  (sub d:(yell now) d:(yell id))  
  =(w (div w-post 7))
::  returns: post itself, last hidden sibling post below and hidden sibling above (if has hidden sibling posts)
++  hidden-siblings
  |=  [id=post-id:athens poz=posts:athens hidden-posts=(set post-id:athens)]
  ^-  (set post-id:athens)
  =/  id-list=(list post-id:athens)  (sort ~(tap in ~(key by poz)) lte)
  ::  find hidden post in list remove posts before him 
  =/  u-ix  (find ~[id] id-list)
  =/  unhide  (~(put in *(set post-id:athens)) id)
  ?~  u-ix  unhide
  =/  ix  (need u-ix)
  |-  ^-  (set post-id:athens)
  ::  if below is hidden
  ?:  ?&  (gth (lent id-list) +(ix))
          (~(has in hidden-posts) (snag +(ix) id-list))
      ==
    =/  next  (snag +(ix) id-list)
    ::  check if there's other siblings below are hidden send card to last one  
    ?:  ?&  (gth (lent id-list) (add 2 ix))
            (~(has in hidden-posts) (snag (add 2 ix) id-list))
        ==
      %=  $
      ix  +(ix)
      ==
    ::  check if above hidden 
    ?:  ?&  (gte (need u-ix) 1)
            (~(has in hidden-posts) (snag (dec (need u-ix)) id-list))
        ==
      (~(gas in unhide) ~[next (snag (dec (need u-ix)) id-list)])
    (~(put in unhide) next)
  ?:  ?&  (gte ix 1)
          (~(has in hidden-posts) (snag (dec ix) id-list))
        ==
    (~(put in unhide) (snag (dec ix) id-list))
  unhide
::
::  returns: all hidden sibling posts below post at id
++  hidden-siblings-below
  |=  [id=post-id:athens id-list=(list post-id:athens) hidden-posts=(set post-id:athens)]
  ^-  (set post-id:athens)
  ::  find hidden post in list remove posts before him 
  =/  u-ix  (find ~[id] id-list)
  =/  unhide  (~(put in *(set post-id:athens)) id)
  ?~  u-ix  unhide
  =/  ix  (need u-ix)
  |-  ^-  (set post-id:athens)
  ?:  =(ix 0)  unhide
    ?.  (~(has in hidden-posts) (snag (dec ix) id-list))
      %=  $
        ix   0
      ==
    %=  $
        unhide  (~(put in unhide) (snag (dec ix) id-list))
        ix      (dec ix)
    ==
::
++  get-post-node 
  |=  [=path =posts:athens]
  |-  ^-  post-node:athens
  =/  =post-id:athens  (slav %da -.path)
  =/  =post-node:athens  (~(got by posts) post-id)
  ?^  +.path
    %=  $
      posts  replies.post-node
      path  +.path
    ==
  post-node
::
++  make-fact-card
  |=  =path
  ^-  card
  :*  %give  %fact  ~[path]  %noun  !>(~)
  ==
::
++  add-post
  |_  [=post-id:athens post-at=path]
  ++  to-new
  |=  session=user-session:athens
  ^-  user-session:athens
  :: ?.  (~(has in hidden-posts.session) (slav %da (rear post-at)))
  ::   session
  :+  hidden-posts.session
      (~(put in new-posts.session) (welp post-at /[(scot %da post-id)]))
  ~
  --
::
++  get-sort-posts
  |=  [new-posts=(set path) at=path]
  ^-  (list path)
  %-  homo
  %+  sort
    %+  skip  ~(tap in new-posts)
    |=(p=path =(~ (find at p)))
  |=  [a=path b=path]
    (lte (slav %da `@t`(rear `(list @ta)`a)) (slav %da `@t`(rear `(list @ta)`b)))
::
++  handle-http-request
  |_  [rid=@ta req=inbound-request:eyre]
  ++  $
    ^+  cor
    ?+    [method.request.req url.request.req]
        %-  emil
        %-  payload-cards
        [[404 ~] ~]
      [%'GET' %'/athens/favicon']
        ::
        %-  emil
        %-  payload-cards
        :-  :-  200
            :~  ['Content-Type' 'image/png']
                ['Cache-Control' 'public, max-age=86400']
            ==
        :-  ~
        %-  as-octs:mimes:html
        favicon
        ::
      [%'GET' %'/athens/app-tile']
        ::
        %-  emil
        %-  payload-cards
        :-  :-  200
            :~  ['Content-Type' 'image/png']
            ==
        :-  ~
        %-  as-octs:mimes:html
        app-tile
        ::
      [%'GET' %'/athens/manifest']
        ::
        %-  emil
        %-  payload-cards
        :-  :-  200
            :~  ['Content-Type' 'application/json']
            ==
        :-  ~
        %-  as-octs:mimes:html
        '''
        {
          "short_name": "Circles",
          "name": "Circles",
          "icons": [
            {
              "src": "/athens/app-tile",
              "sizes": "192x192",
              "type": "image/png"
            }
          ],
          "start_url": "/mast/athens",
          "display": "standalone",
          "theme_color": "#000000",
          "background_color": "#000000"
        }
        '''
      [%'POST' %'/athens/import']
        ::
        ::  from the root of the repo:
        ::  curl -X POST http://localhost/athens/import --data-binary @FORREST.hoon
        ::
        ::    (list [[date author content] $])
        ::
        ::  :~
        ::    :-  :+  ~2025.1.2..12.01.00  ~nec
        ::        '''
        ::        first post
        ::        '''
        ::      :~
        ::        :-  :+  ~2025.1.2..12.02.00  ~nec
        ::            '''
        ::            replying to my own post
        ::            '''
        ::          :~
        ::            :-  :+  ~2025.1.2  ~bus
        ::                'hello nec'
        ::              ~
        ::          ==
        ::      ==
        ::    :-  :+  ~2025.1.3..14.01.01  ~bus
        ::        'another post'
        ::      ~
        ::  ==
        ::
        =/  body=@t
          ~|  'body of POST must be text'
          +:(need body.request.req)
        =.  posts
          %-  ~(uni by posts)
          (txt-to-posts body)
        %-  emil
        %-  payload-cards
        :-  :-  200  ~
        ~
    ==
  ++  payload-cards
    ::
    |=  pl=simple-payload:http
    :~  [%give %fact ~[/http-response/[rid]] [%http-response-header !>(-.pl)]]
        [%give %fact ~[/http-response/[rid]] [%http-response-data !>(+.pl)]]
        [%give %kick ~[/http-response/[rid]] ~]
    ==
  ++  txt-to-posts
    ::
    |_  txt=cord
    ++  $
      =/  vas  (slap !>(..onan) (ream txt))
      =/  lis  !<(imports vas)
      =|  out=posts:athens
      =|  wen=@dr
      |-
      ^+  out
      ?~  lis  out
      %-  (slog (crip "importing post: {<when.i.lis>} {<author.i.lis>}") ~)
      =.  out
        %+  ~(put by out)  (add when.i.lis wen)
        :-  [author.i.lis content.i.lis]
        %=  $
          out  ~
          lis  replies.i.lis
          wen  (add ~s1 wen)
        ==
      %=  $
        lis  t.lis
        wen  +(wen)
      ==
      ::
    +$  imports  (list import-node)
    +$  import-node
      $~  [[*@da *@p *@t] ~]
      [[when=@da author=@p content=@t] replies=imports]
    --
  --
--

