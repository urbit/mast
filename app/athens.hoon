/-  athens, mast
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
!:
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
        =user-sessions:athens
        access=access-0:athens
    ==
  ++  state-0-to-1
    |=  zero=state-0
    ^-  state-1
    :*  %state-1
        posts.zero
        user-sessions.zero
        %*  .  *access:athens
          mode  ?:(public.access.zero %public %private)
          blacklist  blacklist.access.zero
          members  members.access.zero
        ==
    ==
  --
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
    [%posts-all ~]
      :^  ~  ~  %$  !>
      [%athens-post-list !>((get-post-key-paths posts))]
    ::
    [%posts rest=^]
      =/  =post-node:athens  (get-post-node rest.pole posts)
      =/  rep-num  (count-replies replies.post-node)
      :^  ~  ~  %$  !>
      [%athens-post !>([[post.post-node rep-num] (get-post-key-paths replies.post-node)])]
    ::
    [%view who=@ta rest=^]
      ^-  (unit (unit cage))
      =/  usr  (~(get by user-sessions) (slav %p who.pole))
      :^  ~  ~  %$  !>
      [%noun !>((get-view rest.pole usr posts))]
    ::
    [%new who=@ta rest=^]
      =/  usr  (~(get by user-sessions) (slav %p who.pole))
      ?~  usr  :^  ~  ~  %$  !>  [%noun !>(~)]
      =/  new-posts  (get-sort-posts new-posts.u.usr rest.pole)
      ?:  ?&  =((tail rest.pole) /)
              =(%hidden -:(get-view rest.pole usr posts))
          ==
        =/  siblings  ~(tap in (hidden-siblings-below (slav %da (rear rest.pole)) posts hidden-posts.u.usr))
        =/  new-posts
          %-  zing
          %+  turn  siblings 
          |=  i=post-id:athens
          =/  sib-path  /[(scot %da i)]
          (get-sort-posts new-posts.u.usr sib-path)
        :^  ~  ~  %$  !>  [%noun !>(new-posts)]
      :^  ~  ~  %$  !>  [%noun !>(new-posts)]
    ::
    [%access ~]
      :^  ~  ~  %$  !>
      [%athens-access !>(access)]
    ::
  ==
::
++  on-agent  |=([wire sign:agent:gall] ^-((quip card _this) !!))
++  on-arvo   |=([wire sign-arvo] ^-((quip card _this) !!))
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
        %unhide-post
      %-  unhide-post  at.act
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
      :~  %-  make-fact-card  /r/posts-all
      ==
  =/  cards  *(list card)
  =/  at=path  post-at
  |-  ^-  (list card)
  ?:  =(/ (tail at))
    (snoc `(list card)`cards (make-fact-card (weld /r/posts `(list @ta)`at)))
  =/  c  (snoc `(list card)`cards (make-fact-card (weld /r/posts `(list @ta)`at)))
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
  %-  make-fact-card  (weld /r/posts patch-at)
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
    %-  make-fact-card  /r/posts-all
  %-  make-fact-card  (weld /r/posts (snip at))
::
++  hide-post
  |=  at=path
  ^+  cor
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
    %-  make-fact-card  (weld /r/view/[(scot %p user)] (weld (snip at) /[(scot %da i)]))
  %-  emit
  %-  make-fact-card  (weld /r/view/[(scot %p user)] at)
::
++  unhide-post
  |=  at=path
  ^+  cor
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
    %-  make-fact-card  (weld /r/view/[(scot %p user)] at)
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
  =/  c  (snoc `(list card)`cards (make-fact-card (weld /r/view/[(scot %p user)] `(list @ta)`at)))
  %=  $
    at   (snip `path`at)
    cards  c
  ==
  ++  parent-data
    ^-  [(set post-id:athens) (list card)]
    ?:  =(/ (tail at))  [*(set post-id:athens) ~]
    =/  replies  replies:(get-post-node `path`(snip `(list @ta)`at) posts)
    =/  unhide  (hidden-siblings-below id replies hidden-posts.usr)
    :-
      %-  %~  dif  in 
      hidden-posts.usr
      unhide
    %+  turn  ~(tap in unhide)
    |=  id=post-id:athens
    %-  make-fact-card  (weld /r/view/[(scot %p user)] (weld (snip at) /[(scot %da id)]))
--
::
++  set-door-code
  |=  code=@t
  ^+  cor
  =.  door-code.access  code
  %-  emit
  %-  make-fact-card  /r/access
  ::
++  gated-sign-in
  |=  [comet=@p id=@p]
  ^+  cor
  =.  accounts.access  (~(put by accounts.access) comet id)
  %-  emit
  %-  make-fact-card  /r/access
::
++  set-access-mode
  |=  =term
  ^+  cor
  =.  mode.access  (access-mode:athens term)
  %-  emit
  %-  make-fact-card  /r/access
  ::
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
      %-  make-fact-card  /r/access
    %public
      ?^  (find ids blacklist.access)  cor
      =.  blacklist.access  (welp ids blacklist.access)
      %-  emit
      %-  make-fact-card  /r/access
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
      %-  make-fact-card  /r/access
    %public
      =/  index-id  (find [id]~ blacklist.access)
      ?~  index-id  cor
      =.  blacklist.access  (oust [(need index-id) 1] blacklist.access)
      %-  emit
      %-  make-fact-card  /r/access
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
  |=  [post-path=path usr=(unit user-session:athens) =posts:athens]
  ^-  view:athens
  ?~  usr  [%old ~]
  =/  id=post-id:athens  (slav %da (rear post-path))
  ?.  (~(has in hidden-posts.u.usr) id)
    ?.  (~(has in new-posts.u.usr) post-path)  [%old ~]
    [%new ~]
  =/  hidden-view
    :-  %hidden
    :-  0
    %-  lent  %-  homo
    %+  skip  ~(tap in new-posts.u.usr)
    |=  p=path
    =(~ (find ~[(rear post-path)] p))
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
      =/  siblings   ~(tap in (hidden-siblings-below id replies hidden-posts.u.usr))
      =/  num-new
        %-  reel  :_  add
        %+  turn  siblings 
        |=  i=post-id:athens
        =/  sib-path  /[(scot %da i)]
        %-  lent  %-  homo
        %+  skip  ~(tap in new-posts.u.usr)
        |=  p=path
        =(~ (find ~[(rear sib-path)] p))
      =/  num  (lent siblings)
      [%hidden [num num-new]]
    hidden-view
  hidden-view
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
::
::  returns: post itself, last hidden sibling post below and hidden sibling above (if has hidden siblingm posts)
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
  |=  [id=post-id:athens poz=posts:athens hidden-posts=(set post-id:athens)]
  ^-  (set post-id:athens)
  =/  id-list=(list post-id:athens)  (get-post-key-id poz)
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
          "short_name": "Athens",
          "name": "Athens",
          "icons": [
            {
              "src": "https://em-content.zobj.net/source/apple/419/classical-building_1f3db-fe0f.png",
              "sizes": "160x160",
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
        ::  curl -X POST http://localhost/athens/import --data-binary @file-to-import.txt
        ::
        ::    (list [[author content] $])
        ::
        ::  :~
        ::    :-  :-  ~nec
        ::        '''
        ::        first post
        ::        '''
        ::      :~
        ::        :-  :-  ~nec
        ::            '''
        ::            replying to my own post
        ::            '''
        ::          :~
        ::            :-  :-  ~bus
        ::                'hello nec'
        ::              ~
        ::          ==
        ::      ==
        ::    :-  :-  ~bus  'another post'
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
      =/  wen  (sub now.bowl ~d1)
      |-
      ^+  out
      ?~  lis  out
      =.  out
        %+  ~(put by out)  wen
        :-  post.i.lis
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
      $~  [*post:athens ~]
      [=post:athens replies=imports]
    --
  --
--