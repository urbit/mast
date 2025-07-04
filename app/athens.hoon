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
    [%posts-all ~]
      :^  ~  ~  %$  !>
      [%athens-post-list !>((get-post-key-paths posts))]
    ::
    [%posts rest=^]
      =/  =post-node:athens  (get-post-node rest.pole posts)
      :^  ~  ~  %$  !>
      [%athens-post !>([post.post-node (get-post-key-paths replies.post-node)])]
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
      =/  new-posts=(list path)
      %-  homo
      %+  sort  
        ;;  (list path)
        %+  skip  ~(tap in new-posts.u.usr)
        |=(=path =(~ (find rest.pole path)))
      |=  [a=path b=path]
      (lte (slav %da `@t`(rear `(list @ta)`a)) (slav %da `@t`(rear `(list @ta)`b)))
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
    %-  handle-http-request
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
      %-  hide-post  at.act
      ::
        %unhide-post
      %-  unhide-post  at.act
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
  ?:  =(~ at)
    cards
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
  ?:  =(1 (lent at))
    %-  make-fact-card  /r/posts-all
  %-  make-fact-card  (weld /r/posts (snip at))
::
++  hide-post
  |=  at=path
  ^+  cor
  =/  usr  (~(get by user-sessions) src.bowl)
  =/  id  (slav %da (rear at))
  =.  user-sessions
    ?~  usr
      =|  new=user-session:athens
      =.  hidden-posts.new  (~(put in hidden-posts.new) id)
      %+  ~(put by user-sessions)  src.bowl  new
    =/  new-rep=(list path)
      %-  homo
      %+  skip  ~(tap in new-posts.u.usr)
      |=(=path =(~ (find at path)))
    =.  hidden-posts.u.usr  (~(put in hidden-posts.u.usr) id)
    =.  new-posts.u.usr
      (~(dif in new-posts.u.usr) (silt new-rep)) 
    %+  ~(put by user-sessions)  src.bowl  u.usr
  %-  emit
  %-  make-fact-card  (weld /r/view/[(scot %p src.bowl)] at)
::
++  unhide-post
  |=  at=path
  ^+  cor
  =/  usr  (~(got by user-sessions) src.bowl)
  =/  id  (slav %da (rear at))
  =/  new-posts=(list path)
    %-  homo
    %+  sort
      %+  skip  ~(tap in new-posts.usr)
      |=(=path =(~ (find at path)))
    |=  [a=path b=path]
      (lte (slav %da `@t`(rear `(list @ta)`a)) (slav %da `@t`(rear `(list @ta)`b)))
  ?~  new-posts
    =.  hidden-posts.usr  (~(del in hidden-posts.usr) id)
    =.  user-sessions  (~(put by user-sessions) src.bowl usr)
    %-  emit
    %-  make-fact-card  (weld /r/view/[(scot %p src.bowl)] at)
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
      (~(put in new-posts-id) id)
  =.  user-sessions  (~(put by user-sessions) src.bowl usr)
  %-  emil
  =/  cards  *(list card)
  =/  at=path  (rear new-posts)
  |-  ^-  (list card)
  ?:  =(~ at)
    (flop cards)
  =/  c  (snoc `(list card)`cards (make-fact-card (weld /r/posts `(list @ta)`at)))
  %=  $
    at   (snip `path`at)
    cards  c
  ==
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
++  get-view
  |=  [post-path=path usr=(unit user-session:athens) =posts:athens]
  ^-  view:athens
  ?~  usr  [%old ~]
  =/  id=post-id:athens  (slav %da (rear post-path))
  ?.  (~(has in hidden-posts.u.usr) id)
    ?.  (~(has in new-posts.u.usr) post-path)  [%old ~]
    [%new ~]
  :-  %hidden
    ::  TODO: count all nested replies
    :-  0
    %-  lent  %-  homo
    %+  skip  ~(tap in new-posts.u.usr)
    |=  p=path
    =(~ (find ~[(rear post-path)] p))
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
  :-  hidden-posts.session
      (~(put in new-posts.session) (welp post-at /[(scot %da post-id)]))
  --
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
      ~&  importing-post/[author.post.i.lis]
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