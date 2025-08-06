/-  *circles
/+  mast, *helpers
/*  favicon  %png  /fil/favicon/png
/*  app-tile  %png  /fil/app-tile/png
|%
+$  card  card:agent:gall
+$  state-0
  $:  %state-0
      =index
      =posts
      =user-sessions
      =access
  ==
--
::
%-  mast
=|  state-0
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
        %state-0  u.old
      ==
    :_  this
    :~
      :*  %pass  /bind  %arvo  %e  %connect  [~ /apps/circles]  %circles
      ==
    ==
  +$  state-n
    $%  state-0
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
  =/  route  ((pole @ta) t.pax)
  ?+  route  ~
    ::
    [%id rest=*]
      ?~  rest.route  ``circles-unit-path+!>(`/)
      ?~  when=(slaw %da -.rest.route)  ~
      ``circles-unit-path+!>((~(get by index) u.when))
    [%above where=*]
      =|  chain=(list (pair path post))
      |-
      =/  =post  (fall (~(get of posts) where.route) *post)
      =.  chain  [[where.route post] chain]
      ?~  where.route  ``circles-above+!>(chain)
      $(where.route (snip `path`where.route))
    [%below where=*]
      :^  ~  ~  %circles-below  !>
      :-  where.route
      %-  sort  :_  gth
      %+  turn
        %~  tap  in
        ~(key by dir:(~(dip of posts) where.route))
      |=  =@ta
      ^-  post-id
      (slav %da ta)
    [%post where=*]
      :^  ~  ~  %circles-post  !>
      (fall (~(get of posts) where.route) *post)
    [%new-posts-below ship=@ta where=*]
      :^  ~  ~  %circles-set-path  !>
      %-  silt
      %-  skim  :_
        |=  =path
        (is-ancestor-or-same path where.route)
      ^-  (list path)
      %~  tap  in
      =<  new-posts
      %+  ~(gut by user-sessions)
        (slav %p ship.route)
      *user-session
    [%new-posts ship=@ta ~]
      :^  ~  ~  %circles-set-path  !>
      =<  new-posts
      %+  ~(gut by user-sessions)
        (slav %p ship.route)
      *user-session
    [%initialized ship=@ta ~]
      :^  ~  ~  %circles-flag  !>
      (~(has by user-sessions) (slav %p ship.route))
    [%access ~]  ``circles-access+!>(access)
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
      %circles-action
    =/  act  !<  action  vase
    ?+  -.act  !!
      %create-post  (create-post +.act)
      %edit-post  (edit-post +.act)
      %delete-post  (delete-post +.act)
      %set-access-mode  (set-access-mode +.act)
      %edit-access-id  (edit-access-id +.act)
      %del-access-id  (del-access-id +.act)
      %gated-set-door-code  (set-door-code +.act)
      %gated-sign-in  (gated-sign-in +.act)
      %initialize-user  initialize-user
      %mark-read  (mark-read +.act)
    ==
    ::
  == 
::
++  create-post
  |=  [parent=path content=@t]
  ^+  cor
  =/  where  (snoc parent (scot %da now.bowl))
  =/  =post  [src.bowl content]
  =.  posts  (~(put of posts) where post)
  =.  index  (~(put by index) now.bowl where)
  =.  user-sessions
    %-  ~(urn by user-sessions)
    |=  [who=@p =user-session]
    ?:  =(who src.bowl)  user-session
    %=  user-session
      new-posts  (~(put in new-posts.user-session) where)
    ==
  %-  emil
  ;:  welp
    %+  turn  (lineage where)
    |=  =path
    %-  make-fact-card  (welp /x/below path)
  ::
    %-  zing
    %+  murn  ~(tap in ~(key by user-sessions))
    |=  who=@p
    ?:  =(who src.bowl)  ~
    :-  ~
    %+  welp
      :~
        %-  make-fact-card  /x/new-posts/[(scot %p who)]
      ==
    %+  turn  (lineage where)
    |=  =path
    %-  make-fact-card  (welp /x/new-posts-below/[(scot %p who)] path)
  ::
  ==
++  edit-post
  |=  [where=path content=@t]
  ^+  cor
  =/  =post  [src.bowl content]
  =.  posts  (~(put of posts) where post)
  %-  emil
  :-  %-  make-fact-card  (welp /x/post where)
  %+  welp
    %+  turn  (lineage where)
    |=  =path
    %-  make-fact-card  (welp /x/above path)
  %+  turn  (lineage where)
  |=  =path
  %-  make-fact-card  (welp /x/below path)
  ::
++  delete-post
  |=  where=path
  ^+  cor 
  =.  posts
    %-  ~(gas of *(axal post))
    %+  skip  
      %~  tap  of  (~(del of posts) where)
    |=  [=path =post]
    (is-ancestor path where)
  =.  user-sessions  
    %-  ~(run by user-sessions)
    |=  sesh=user-session
    :_  error.sesh
        %-  silt
        %+  skip  ~(tap in new-posts.sesh)
        |=(=path (is-ancestor path where))
  %-  emil
  :-  %-  make-fact-card  (welp /x/post where)
  %+  turn  (lineage where)
  |=  =path
  %-  make-fact-card  (welp /x/below path)
  ::
++  set-access-mode
  |=  =term  
  ^+  cor
  =.  mode.access  (access-mode term)
  %-  emit
  %-  make-fact-card  /x/access
::
++  edit-access-id
  |=  ids=(list @p)
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
++  initialize-user
  =.  user-sessions
    %+  ~(put by user-sessions)  src.bowl
    %*  .  *user-session
      new-posts
        ^-  (set path)
        %-  silt
        %+  scag  15
        ^-  (list path)
        %+  turn
          %+  sort  ~(tap by index)
          |=  [a=[=post-id path] b=[=post-id path]]
          (gth post-id.a post-id.b)
        tail
    ==
  %-  emil
  :~  %-  make-fact-card  /x/initialized/[(scot %p src.bowl)]
  ==
::
++  mark-read
  |=  pax=path
  =/  sesh  (~(gut by user-sessions) src.bowl *user-session)
  ?.  (~(has in new-posts.sesh) pax)  cor
  =.  user-sessions
    %+  ~(put by user-sessions)  src.bowl
    %=  sesh
      new-posts  (~(del in new-posts.sesh) pax)
    ==
  %-  emil
  :-  %-  make-fact-card  /x/new-posts/[(scot %p src.bowl)]
  :-  %-  make-fact-card  /x/recent/[(scot %p src.bowl)]
  %+  turn  (lineage pax)
  |=  =path
  %-  make-fact-card  (welp /x/new-posts-below/[(scot %p src.bowl)] path)
::
++  make-fact-card
  |=  =path
  ^-  card
  :*  %give  %fact  ~[path]  %noun  !>(~)
  ==
::
++  handle-http-request
  |_  [rid=@ta req=inbound-request:eyre]
  ++  $
    ^+  cor
    ?+    [method.request.req url.request.req]
        %-  emil
        %-  payload-cards
        [[404 ~] ~]
      [%'GET' %'/apps/circles/favicon']
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
      [%'GET' %'/apps/circles/app-tile']
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
      [%'GET' %'/apps/circles/manifest']
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
              "src": "/apps/circles/app-tile",
              "sizes": "192x192",
              "type": "image/png"
            }
          ],
          "start_url": "/circles",
          "display": "standalone",
          "theme_color": "#000000",
          "background_color": "#000000"
        }
        '''
      [%'POST' %'/apps/circles/import']
        ::
        ::  from the root of the repo:
        ::  curl -X POST http://localhost/apps/circles/import --data-binary @FORUM.hoon
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
        !!
    ==
  ++  payload-cards
    ::
    |=  pl=simple-payload:http
    :~  [%give %fact ~[/http-response/[rid]] [%http-response-header !>(-.pl)]]
        [%give %fact ~[/http-response/[rid]] [%http-response-data !>(+.pl)]]
        [%give %kick ~[/http-response/[rid]] ~]
    ==
  --
--