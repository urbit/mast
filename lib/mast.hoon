/-  *mast
/~  deck  mast  /com
::
:: O╭ ┌┬╮╭─╮╭─╮┌┬┐
:: ╭╯ │││├─┤╰─╮ │
:: ╯O ┴ ┴┴ ┴╰─╯ ┴
::
=>
|%
+$  state-0
  $:  =swab
      =gulf
      =navy
  ==
+$  state-n
  $%  [%state-0 state-0]
  ==
+$  card  card:agent:gall
--
::
|=  you=agent:gall
=>  [[*$>(%state-0 state-n) you=you] +>]
=*  state  -
=<
^-  agent:gall
|_  =bowl:gall
+*  this  .
    cor  ~(. +> [bowl ~])
::
++  on-init
  ^-  (quip card _this)
  =^  cards  state  abet:init:cor
  :-  cards  this
::
++  on-save
  ^-  vase
  =<  save  cor
::
++  on-load
  |=  =vase
  ^-  (quip card _this)
  =^  cards  state  abet:(load:cor vase)
  :-  cards  this
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
  =^  cards  state  abet:(watch:cor path)
  :-  cards  this
::
++  on-leave
  |=  =path
  ^-  (quip card _this)
  =^  cards  state  abet:(leave:cor path)
  :-  cards  this
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  %-  peek:cor  path
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  =^  cards  state  abet:(agent:cor wire sign)
  :-  cards  this
::
++  on-arvo
  |=  [=wire sign=sign-arvo]
  ^-  (quip card _this)
  =^  cards  state  abet:(arvo:cor wire sign)
  :-  cards  this
::
++  on-fail
  |=  [=term =tang]
  ^-  (quip card _this)
  =^  cards  state  abet:(fail:cor term tang)
  :-  cards  this
--
::
|_  [=bowl:gall cards=(list card)]
++  cor   .
++  abet  [(flop cards) state]
++  emit  |=  =card  cor(cards [card cards])
++  emil  |=  caz=(list card)  cor(cards (welp (flop caz) cards))
++  our-ta  (scot %p our.bowl)
++  now-ta  (scot %da now.bowl)
++  bek  /[our-ta]/[q.byk.bowl]/[now-ta]
++  bak  |=  =desk  /[our-ta]/[desk]/[now-ta]
++  bem  |=  =path  (welp bek path)
++  bam  |=  [=desk =path]  (welp (bak desk) path)
::
:: ++  cleanup-timer
::   =/  tim  `@da`(add ~d1 now.bowl)
::   =/  wir  `wire`/mast/cleanup
::   =/  wab  swab
::   |%
::   ++  set
::     ^+  cor
::     =.  swab  tim
::     %-  emit  wait
::   ++  reset
::     ^+  cor
::     =.  swab  tim
::     %-  emil  [wait rest ~]
::   ++  rest  `card`[%pass wir %arvo %b %rest wab]
::   ++  wait  `card`[%pass wir %arvo %b %wait tim]
::   --
::
++  parse-channel-data
  |=  jon=json
  ^-  [buoy (list rode) crow]
  =,  dejs:format
  %.  jon
  %-  ot
  :~  ses+so       :: expexts the session id string,
      ros+(ar so)  :: and its component key ancestry
      path+pa
      data+(om so)
  ==
::
++  make-client-sub-path
  |=  [src=ship ses=buoy]
  ^-  path
  /mast/ui/[(scot %p src)]/[`@t`ses]
::
++  parse-client-sub-path
  |=  poe=(pole @ta)
  ^-  [ship buoy]
  ?>  ?=([%mast %ui who=@ta ses=@ta ~] poe)
  :-  (slav %p who.poe)  ses.poe
::
++  make-direct-http-cards
  |=  [rid=@ta hed=response-header.simple-payload:http dat=(unit octs)]
  ^-  (list card)
  :~  [%give %fact ~[/http-response/[rid]] [%http-response-header !>(hed)]]
      [%give %fact ~[/http-response/[rid]] [%http-response-data !>(dat)]]
      [%give %kick ~[/http-response/[rid]] ~]
  ==
::
++  make-channel-card
  |=  [src=ship ses=buoy jon=json]
  ^-  card
  :*  %give  %fact  [(make-client-sub-path src ses) ~]
      %json  !>(jon)
  ==
::
++  make-script-sub-card
  ^-  card
  =/  des  q.byk.bowl
  =/  paf  /lib/mast/js
  :*  %pass  /mast/script/sub  %arvo  %c
      %warp  our.bowl  des  [~ %next %z da+now.bowl paf]
  ==
::
++  make-script-cache-card
  ^-  card
  =/  url  '/mast-js'
  =/  fil  .^(@t %cx (bem /lib/mast/js))
  =/  lod
    ^-  (unit cache-entry:eyre)
    :*  ~
        |
        %payload
        [200 ['Content-Type' 'application/javascript'] ~]
        [~ (as-octs:mimes:html fil)]
    ==
  :*  %pass  /mast/script/cache  %arvo  %e  %set-response  url  lod
  ==
::
++  make-eyre-bind-card
  |=  url=path
  ^-  card
  :*  %pass  /mast/eyre/bind  %arvo  %e  %connect  [~ url]  dap.bowl
  ==
::
++  parse-url
  |=  cod=cord
  |^  ^-  (unit rope)
  =/  tap  (trip cod)
  =/  sep  (find ['?' ~] tap)
  =/  [paf=tape par=tape]
    ?~  sep  [tap ~]
    :-  (scag u.sep tap)  (slag u.sep tap)
  =/  puf  (parse-path paf)
  ?~  puf  ~
  ?~  u.puf
    :-  ~
    :+  %$
        ~
        (parse-query par)
  :-  ~
  :+  i.u.puf
      t.u.puf
      (parse-query par)
  ::
  ++  parse-path
    |=  tap=tape
    ^-  (unit path)
    %+  rust  tap
    %+  cook
      |=  p=path
      ^-  path
      ?.  .?(p)  ~
      ?.  =(%$ (rear p))  p
      %-  snip  p
    ;~  pfix  fas  (most fas url-segment)
    ==
  ++  url-segment
    %+  cook  |=(a=tape (rap 3 ^-((list @) a)))
    %-  star
    ;~  pose  alf  nud  hep  dot  sig  cab  cen-encoded
    ==
  ++  cen-encoded
    %+  cook  |=(a=(list @) `@t`(rap 3 a))
    ;~  pfix  cen  (most cen mes)
    ==
  ++  parse-query
    |=  tap=tape
    ^-  quay
    %-  malt
    =<  ?~(. ~ u)
    ^-  (unit (list (pair @t @t)))
    %+  rust  tap
    ;~  pfix  wut  (most ;~(pose pam mic) query-param)
    ==
  ++  query-param
    %+  cook  |=([k=@t rest=(list @t)] [k ?~(rest '' ?>(?=(~ t.rest) i.rest))])
    %+  most  tis  url-segment
  --
::
++  print-url
  |=  rop=rope
  ^-  cord
  %-  crip
  %+  weld  (trip bas.rop)
  %+  weld  (spud rut.rop)
  =/  qus  ~(tap by que.rop)
  ?~  qus  ~
  :-  '?'
  |-  ^-  tape
  %+  weld
    ?:  =('' q.i.qus)  (trip p.i.qus)
    %+  weld  (trip p.i.qus)
    :-  '='  (trip q.i.qus)
  ?~  t.qus  ~
  :-  '&'
  %=  $
    qus  t.qus
  ==
::
++  init
  ^+  cor
  =^  caz  you  ~(on-init you bowl)
  =.  cor  (handle-namespace-changes caz)
  :: TODO:
  :: =.  cor  set:cleanup-timer
  %-  emil
  :*  make-script-sub-card
      make-script-cache-card
      (make-eyre-bind-card /[dap.bowl])
      caz
  ==
::
++  save
  ^-  vase
  !>  [%mast `state-n`-:state ~(on-save you bowl)]
::
++  load
  |=  vaz=vase
  ^+  cor
  ?.  ?=([%mast *] +.vaz)
    =^  caz  you  (~(on-load you bowl) vaz)
    =.  cor  (handle-namespace-changes caz)
    %-  emil  caz
  =+  !<  [%mast maz=state-n nez=vase]  vaz
  =^  caz  you  (~(on-load you bowl) nez)
  =.  cor  (handle-namespace-changes caz)
  =.  cor
    %-  emil
    :*  make-script-sub-card
        make-script-cache-card
        (make-eyre-bind-card /[dap.bowl])
        caz
    ==
  ?-  -.maz
    ::
      %state-0
    ::=.  -.state  maz
    :: TODO:
    :: =.  cor  reset:cleanup-timer
    cor
    ::
  ==
::
++  fail
  |=  [tem=term tan=tang]
  ^+  cor
  =^  caz  you  (~(on-fail you bowl) tem tan)
  =.  cor  (handle-namespace-changes caz)
  %-  emil  caz
::
++  peek
  |=  poe=(pole @ta)
  ^-  (unit (unit cage))
  %-  ~(on-peek you bowl)  poe
::
++  watch
  |=  poe=(pole @ta)
  ^+  cor
  ?:  ?=([%mast *] poe)  cor
  =^  caz  you  (~(on-watch you bowl) poe)
  =.  cor  (handle-namespace-changes caz)
  %-  emil  caz
::
++  leave
  |=  poe=(pole @ta)
  ^+  cor
  ?:  ?=([%mast *] poe)  cor
  =^  caz  you  (~(on-leave you bowl) poe)
  =.  cor  (handle-namespace-changes caz)
  %-  emil  caz
::
++  agent
  |=  [wir=(pole @ta) sin=sign:agent:gall]
  ^+  cor
  =^  caz  you  (~(on-agent you bowl) wir sin)
  =.  cor  (handle-namespace-changes caz)
  %-  emil  caz
::
++  arvo
  |=  [wir=wire sin=sign-arvo]
  ^+  cor
  ?.  ?=([%mast *] wir)
    =^  caz  you  (~(on-arvo you bowl) wir sin)
    =.  cor  (handle-namespace-changes caz)
    %-  emil  caz
  ?+  sin  cor
    ::
      [%clay %writ *]
    ?+  wir  cor
      ::
        [%mast %script *]
      ?~  p.sin  cor
      %-  emil
      :~  make-script-sub-card
          make-script-cache-card
      ==
      ::
    ==
    ::
      [%behn %wake *]
    cor
    :: TODO:
    :: =.  cor  set:cleanup-timer
    :: ?^  error.sin  cor
    :: =/  nel  .^(channel-state:eyre %e (bak %channel-state))
    :: =/  kil
    ::   %+  skip  ~(tap in ~(key by gulf))
    ::   |=  [s=ship b=buoy]
    ::   %-  ~(has by session.nel)  `@t`b
    :: %-  del-component-state  [%clean kil]
    ::
  ==
::
++  poke
  |=  [mak=mark vaz=vase]
  ^+  cor
  ?+  mak
    ::
    =^  caz  you  (~(on-poke you bowl) mak vaz)
    =.  cor  (handle-namespace-changes caz)
    %-  emil  caz
    ::
      %handle-http-request
    =+  !<  [rid=@ta req=inbound-request:eyre]  vaz
    =/  rup  (parse-url url.request.req)
    ?~  rup
      %-  emil
      %^  make-direct-http-cards  rid  [400 ['Content-Type' 'text/plain'] ~]
      :-  ~
      %-  as-octs:mimes:html  '400 Bad Request: Malformed URL'
    ?.  ?&  =('GET' method.request.req)
          =(dap.bowl bas.u.rup)
      ==
      :: fall through to the nested agent
      =^  caz  you  (~(on-poke you bowl) mak vaz)
      =.  cor  (handle-namespace-changes caz)
      %-  emil  caz
    =/  ses  `buoy`(crip ((d-co:co 1) now.bowl))
    =/  ui-core  (ui-abed:ui [%& src.bowl ses u.rup])
    =^  [wak=wake sal=manx]  ui-core  ui-full:ui-core
    =.  sal
      ?.  ?&  ?=([* * ~] c.sal)
              ?=(%html n.g.sal)
              ?=(%head n.g.i.c.sal)
              ?=(%body n.g.i.t.c.sal)
          ==
        ~&  >>>  [%malformed-root-component dap.bowl]
        !!
      %_  sal
        a.g
          :*  [%our +:(scow %p our.bowl)]
              [%app (trip dap.bowl)]
              [%ses (trip `@t`ses)]
              [%sub (spud (make-client-sub-path src.bowl ses))]
              a.g.sal
          ==
        c.i.c  [;script(src "/mast-js"); c.i.c.sal]
      ==
    =:  gulf  ui-abet:ui-core
        navy  (update-navy src.bowl ses wak)
      ==
    %-  emil
    %^  make-direct-http-cards  rid  [200 ['Content-Type' 'text/html'] ~]
    :-  ~
    %-  as-octt:mimes:html
    %-  en-xml:html  sal
    ::
      %json
    =+  !<  jon=json  vaz
    ?.  ?&  ?=(%a -.jon)
            ?=(^ p.jon)
            ?=(^ t.p.jon)
            =([%s 'mast'] i.p.jon)
        ==
        :: fall through to the nested agent
        =^  caz  you  (~(on-poke you bowl) mak vaz)
        =.  cor  (handle-namespace-changes caz)
        %-  emil  caz
    ?+  i.t.p.jon  !!
      ::
        [%s %'event']
      ?>  ?=(^ t.t.p.jon)
      =/  [ses=buoy ros=(list rode) cro=crow]  (parse-channel-data i.t.t.p.jon)
      =^  caz  you  (ui-event:(ui-abed:ui %| src.bowl ses) ros cro)
      =.  cor  (handle-namespace-changes caz)
      %-  emil  caz
      ::
        [%s %'kill']
      ?>  ?=([[%s @] ~] t.t.p.jon)
      :: TODO:
      :: %-  del-component-state  [%clean [[src.bowl p.i.t.t.p.jon] ~]]
      cor
    ==
  ==
::
++  update-navy
  |=  [src=ship ses=buoy wak=wake]
  ^-  ^navy
  ?~  wak  navy
  =/  nav  (~(get by navy) q.i.wak)
  %=  $
    wak  t.wak
    navy
      ?-  -.i.wak
          %add
        ?~  nav
          %+  ~(put by navy)  q.i.wak  [[[src ses] p.i.wak] ~ ~]
        %+  ~(put by navy)  q.i.wak
        %-  ~(put in u.nav)  [[src ses] p.i.wak]
          %del
        ?~  nav  navy
        =.  u.nav  (~(del in u.nav) [[src ses] p.i.wak])
        ?~  u.nav
          %-  ~(del by navy)  q.i.wak
        %+  ~(put by navy)  q.i.wak  u.nav
      ==
  ==
::
++  handle-namespace-changes
  |=  caz=(list card)
  ^+  cor
  :: get namespace changes from cards
  =/  mes
    ^-  mess
    %+  murn  caz
    |=  cad=card
    ^-  (unit grog)
    ?+  cad  ~
        [%pass * %grow *]  [~ spur.q.cad %put page.q.cad]
        [%pass * %tend *]  [~ path.q.cad %put page.q.cad]
        [%pass * %tomb *]  [~ spur.q.cad %tom case.q.cad]
        [%pass * %cull *]  [~ spur.q.cad %cul case.q.cad]
    ==
  :: temporary, for the wrapper:
  :: apply namespace changes locally for rendering on change
  =.  sky.bowl
    =/  fon  ((on @ud (pair @da (each page @uvI))) lte)
    |-  ^-  (map path fans:gall)
    ?~  mes  sky.bowl
    =/  fan  (~(get by sky.bowl) p.i.mes)
    %=  $
      mes  t.mes
      sky.bowl
        ?-  -.q.i.mes
            %put
          %+  ~(put by sky.bowl)  p.i.mes
          ?~  fan  (put:fon *fans:gall 0 [now.bowl %& page.q.i.mes])
          =/  rum  (ram:fon u.fan)
          ?~  rum  (put:fon u.fan 0 [now.bowl %& page.q.i.mes])
          %:  put:fon  u.fan  +(key.u.rum)  [now.bowl %& page.q.i.mes]
          ==
            %tom
          =/  num  ?>(?=(%ud -.case.q.i.mes) p.case.q.i.mes)
          ?~  fan  sky.bowl
          =/  val  (get:fon u.fan num)
          ?:  ?|  ?=(~ val)
                  ?=(%| -.q.u.val)
              ==
            sky.bowl
          %+  ~(put by sky.bowl)  p.i.mes
          %:  put:fon  u.fan  num  u.val(q |/(shax (jam p.q.u.val)))
          ==
            %cul
          =/  num  ?>(?=(%ud -.case.q.i.mes) p.case.q.i.mes)
          ?~  fan  sky.bowl
          %+  ~(put by sky.bowl)  p.i.mes
          %:  lot:fon  u.fan  [~ num]  ~
          ==
        ==
    ==
  :: get unique components to rerender
  =/  pon
    %~  tap  in
    %+  roll  mes
    |=  [gog=grog acc=(set (pair [ship buoy] (list rode)))]
    %-  ~(uni in acc)
    %+  ~(gut by navy)  p.gog  ~
  :: rerender each
  |-  ^+  cor
  ?~  pon  cor
  =/  ui-core  (ui-abed:ui %| p.i.pon)
  =^  [wak=wake sal=manx]  ui-core  (ui-update:ui-core q.i.pon)
  =.  cor
    %-  emit
    %^  make-channel-card
        -.p.i.pon
        +.p.i.pon
        [%s (crip (en-xml:html sal))]
  %=  $
    pon  t.pon
    gulf  ui-abet:ui-core
    navy  (update-navy -.p.i.pon +.p.i.pon wak)
  ==
::
++  ui
  |_  [src=ship ses=buoy rop=rope yel=isle]
  ++  ui-core  .
  ++  ui-abet  (~(put by gulf) [src ses] [rop yel])
  ++  ui-abed
    |=  %+  each
            [s=ship b=buoy r=rope]
            [s=ship b=buoy]
    ?-  +<-
      :: open a new session
        %&
      :: the root component defaults to the com file with the same name
      =/  lin  `line`[dap.bowl ~ ~]
      %_  ui-core
        src  s.p
        ses  b.p
        rop  r.p
        yel  [lin ~]
      ==
      :: get an existing session
        %|
      =/  q=[r=rope y=isle]  (~(got by gulf) [s.p b.p])
      %_  ui-core
        src  s.p
        ses  b.p
        rop  r.q
        yel  y.q
      ==
    ==
  ::
  ++  ui-full
    ^-  [[wake manx] _ui-core]
    :: the root component's key is null
    =/  key  ''
    =/  [yul=isle sal=manx]  (render key p.yel ~)
    :_  ui-core(yel yul)
    :_  sal
    %+  weld  (diff-resources [key ~] yel yul)
    %+  weld
        %^  make-resource-effects
            %del
            [key ~]
            ~(val by (~(dif by res.p.yel) res.p.yul))
    %^  make-resource-effects
        %add
        [key ~]
        ~(val by (~(dif by res.p.yul) res.p.yel))
  ::
  ++  ui-kill
    ^-  [wake _ui-core]
    =/  key  ''
    =/  kil  [p.yel ~]
    :_  ui-core(yel kil)
    %+  weld  (diff-resources [key ~] yel kil)
    %^  make-resource-effects
        %del
        [key ~]
        ~(val by res.p.yel)
  ::
  ++  ui-update
    |=  ros=(list rode)
    ^-  [[wake manx] _ui-core]
    =/  old  (get-isle ?>(?=(^ ros) ros))
    =/  [new=isle sal=manx]  (render (rear ros) old)
    :_  ui-core(yel (set-isle ?>(?=(^ ros) ros) new))
    :-  (diff-resources ros old new)
        sal
  ::
  ++  ui-event
    |=  [ros=(list rode) cro=crow]
    ^-  [(list card) _you]
    =/  yul  (get-isle ?>(?=(^ ros) ros))
    =/  com  (~(got by deck) com.p.yul)
    =/  blo  (~(spar com (make-hull p.yul)) cro)
    =/  caz  *(list card)
    =/  pof  ~(. you spoof-bowl)
    |-  ^+  [caz you]
    ?~  blo  [caz you]
    :: TODO:
    :: ?:  =(%mast-action p.i.blo)
    ::   %=  $
    ::     blo  t.blo
    ::     caz  [[%pass /mast/action %agent [our.bowl dap.bowl] %poke i.blo] caz]
    ::   ==
    =^  cuz  you  (on-poke:pof i.blo)
    %=  $
      blo  t.blo
      caz  (weld caz cuz)
    ==
  ::
  ++  get-isle
    |=  ros=(lest rode)
    ^-  isle
    ?~  t.ros  yel
    %=  $
      ros  t.ros
      yel  (~(got by q.yel) i.ros)
    ==
  ::
  ++  set-isle
    |=  [ros=(lest rode) yul=isle]
    ^-  isle
    ?~  t.ros  yul
    %_  yel
      q
        %+  ~(put by q.yel)  i.ros
        %=  $
          ros  t.ros
          yel  (~(got by q.yel) i.ros)
        ==
    ==
  ::
  ++  render
    |=  [rod=rode lin=line old=(map rode isle)]
    ^-  [isle manx]
    :: rod is the key for the current component
    :: passed in on iteration of render
    =/  com  (~(got by deck) com.lin)
    =/  mal  `marl`[~(sail com (make-hull lin)) ~]
    =-  ?>  ?=(^ p)
        :-  [lin q]
        :: add this component's key to the root
        :: element of the component as a %mast attribute
        %_  i.p
          a.g  [[%mast (trip rod)] a.g.i.p]
        ==
    |-  ^-  (pair marl (map rode isle))
    %^  spin
        mal
        *(map rode isle)
    |=  [m=manx a=(map rode isle)]
    =^  b  m
      ^-  [(map rode isle) manx]
      ?.  =(%mast n.g.m)
        =+  ^$(mal c.m)
        :-  q
            m(c p)
      =/  l  (parse-component-element m)
      :: make a key for the nested component
      :: using its parent's key and its line
      =/  k  (crip ((v-co:co 1) (mug [rod l])))
      =/  y  (~(get by old) k)
      :: if this session has already rendered
      :: this child component, don't recurse
      :: and leave the placeholder element
      ?^  y
        :-  [[k u.y] ~ ~]
            m
      =^  i  m
        %=  ^^$
          rod  k
          lin  l
          old  ~
        ==
      :-  [[k i] ~ ~]
          m
    :-  m
        (~(uni by a) b)
  ::
  ++  diff-resources
    |=  [unc=(list rode) old=isle new=isle]
    |^
    ^-  wake
    %+  weld  (del-or-add %del (~(dif by q.old) q.new))
    %+  weld  (del-or-add %add (~(dif by q.new) q.old))
    ^-  wake
    %-  ~(rep in ~(key by (~(int by q.old) q.new)))
    |=  [r=rode a=wake]
    ^-  wake
    %+  weld  a
    %=  ^$
        unc  (snoc unc r)
        old  (~(got by q.old) r)
        new  (~(got by q.new) r)
    ==
    ::
    ++  del-or-add
    |=  [wat=?(%del %add) dis=(map rode isle)]
    ^-  wake
    %-  ~(rep by dis)
    |=  [[k=rode v=isle] a=wake]
    =.  unc  (snoc unc k)
    %+  weld  a
    %+  weld
        %^  make-resource-effects
            wat
            unc
            ~(val by res.p.v)
    %=  ^$
        dis  q.v
    ==
    ::
    --
  ::
  ++  make-resource-effects
    |=  [act=?(%add %del) unc=(list rode) res=(list path)]
    ^-  wake
    %+  turn  res
    |=  paf=path
    ^-  tide
    :+  act
        unc
        paf
  ::
  ++  parse-component-element
    |=  sal=manx
    ^-  line
    ?>  =(%mast n.g.sal)
    %+  roll  a.g.sal
    |=  [[k=mane v=tape] a=line]
    ?+  k  a
      [%hook @]  a(com +.k)
      [%gust @]  a(par (~(put by par.a) +.k (crip v)))
      [%gale @]  a(res (~(put by res.a) +.k (scan v stap)))
    ==
  ::
  ++  make-hull
    |=  lin=line
    ^-  hull
    :*  our.bowl
        src
        ses
        bas.rop
        rut.rop
        que.rop
        now.bowl
        eny.bowl
        par.lin
        (hydrate-component res.lin)
    ==
  ::
  ++  spoof-bowl
    %_  bowl
      src  src
      sap  /gall/[dap.bowl]
    ==
  ::
  ++  hydrate-component
    |=  res=pool
    ^-  gale
    =/  pof  ~(. you spoof-bowl)
    =/  fon  ((on @ud (pair @da (each page @uvI))) lte)
    %-  ~(rep by res)
    |=  [[nam=@tas paf=path] acc=gale]
    =/  fan  (~(get by sky.bowl) paf)
    ?~  fan  acc
    =/  rum  (ram:fon u.fan)
    ?~  rum  acc
    ?:  ?=(%| -.q.val.u.rum)  acc
    %+  ~(put by acc)  nam
    :+  paf
        p.q.val.u.rum
    %-  ~(rep by sky.bowl)
    |=  [[k=path v=fans:gall] a=(list path)]
    ?.  ?=([~ %0] (find paf k))  a
    ?.  ?=([~ @ %& *] (ram:fon v))  a
    :-  k  a
  ::
  --
::
--

