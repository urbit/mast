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
  :_  this
  :~
    :*  %pass  /bind  %arvo  %e  %connect  [~ /athens]  %athens
    ==
  ==
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
      [%noun !>(hid)]
    ::
    [%access ~]
      :^  ~  ~  %$  !>
      [%athens-access !>(access)]
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
      %handle-http-request
    %-  handle-manifest
    !<  [rid=@ta req=inbound-request:eyre]  vase
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
        %hide-post
      %-  hide-post  id.act
      ::
        %unhide-post
      %-  unhide-post  id.act
      ::
        %access-public
      %-  access-public  public.act
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
  =.  user-sessions
    ?~  usr
      =|  new=user-session:athens
      =.  hidden-posts.new  (~(put in hidden-posts.new) id)
      %+  ~(put by user-sessions)  src.bowl  new
    =.  hidden-posts.u.usr  (~(put in hidden-posts.u.usr) id)
    %+  ~(put by user-sessions)  src.bowl  u.usr
  %-  emit
  %-  make-fact-card  /r/hidden/[(scot %p src.bowl)]/[(scot %da id)]
::
++  unhide-post
  |=  id=post-id:athens
  ^+  cor
  =/  usr  (~(got by user-sessions) src.bowl)
  =.  hidden-posts.usr  (~(del in hidden-posts.usr) id)
  =.  user-sessions  (~(put by user-sessions) src.bowl usr)
  %-  emit
  %-  make-fact-card  /r/hidden/[(scot %p src.bowl)]/[(scot %da id)]
::
++  access-public
  |=  public=?
  ^+  cor
  ?:  =(public public.access)  cor
  =.  access  :*  public 
                  members.access
                  blacklist.access
              ==
  %-  emit
  %-  make-fact-card  /r/access
::
++  edit-access-id
  |=  ids=(list @p)
  ^+  cor
  ?.  public.access
    =.  members.access  ~(tap in (silt (welp members.access ids)))
    %-  emit
    %-  make-fact-card  /r/access
  =.  blacklist.access  ~(tap in (silt (welp blacklist.access ids)))
  %-  emit
  %-  make-fact-card  /r/access
::
++  del-access-id
  |=  id=@p
  ^+  cor
  =/  index-id  %+  find  [id]~ 
                ?.  public.access
                  members.access
                blacklist.access
  ?~  index-id  cor
  ?.  public.access
    =.  members.access  (oust [(need index-id) 1] members.access)
    %-  emit
    %-  make-fact-card  /r/access
  =.  blacklist.access  (oust [(need index-id) 1] blacklist.access)
  %-  emit
  %-  make-fact-card  /r/access
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
++  handle-manifest
  |=  [rid=@ta req=inbound-request:eyre]
  ^+  cor
  =;  pl=simple-payload:http
    %-  emil
    :~  [%give %fact ~[/http-response/[rid]] [%http-response-header !>(-.pl)]]
        [%give %fact ~[/http-response/[rid]] [%http-response-data !>(+.pl)]]
        [%give %kick ~[/http-response/[rid]] ~]
    ==
  ?+    url.request.req
      [[404 ~] ~]
    %'/athens/manifest'
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
        "start_url": "/mast/athens/post/athens",
        "display": "standalone",
        "theme_color": "#000000",
        "background_color": "#000000"
      }
      '''
  ==
::
--

