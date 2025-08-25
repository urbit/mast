/-  *mast
/~  tui-deck  mast  /tui
/*  mast-js  %js  /lib/mast/js
::
:: O╭ ┌┬╮╭─╮╭─╮┌┬┐
:: ╭╯ │││├─┤╰─╮ │
:: ╯O ┴ ┴┴ ┴╰─╯ ┴
::
=>
|%
+$  state-0
  $:  swab=@da
      =navy
      =gulf
      =dock
      =deck
      =tui-gulf
      =tui-navy
      =tui-dock
  ==
+$  state-n
  $%  [%state-0 state-0]
  ==
+$  card  card:agent:gall
::
+$  tui-isle  $~([*line ~] (pair line (map rode tui-isle)))
+$  tui-gulf  (map [ship buoy buoy] (pair rope tui-isle))
+$  tui-navy  (map path (set [ship buoy (list rode)]))
+$  tui-dock  dock
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
++  script-element
  ^-  manx
  ;script: {(trip mast-js)}
::
++  bind-eyre-url
  |=  url=path
  ^-  card
  :*  %pass  /mast/bind-eyre-url  %arvo  %e  %connect  [~ url]  dap.bowl
  ==
::
++  unbind-eyre-url
  |=  url=path
  ^-  card
  :*  %pass  /mast/unbind-eyre-url  %arvo  %e  %disconnect  [~ url]
  ==
::
++  cleanup-timer
  =/  tim  `@da`(add ~d1 now.bowl)
  =/  wir  `wire`/mast/cleanup
  =/  wab  swab
  |%
  ++  set
    ^+  cor
    =.  swab  tim
    %-  emit  wait
  ++  reset
    ^+  cor
    =.  swab  tim
    %-  emil  [wait rest ~]
  ++  rest  `card`[%pass wir %arvo %b %rest wab]
  ++  wait  `card`[%pass wir %arvo %b %wait tim]
  --
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
++  parse-channel-data
  |=  jon=json
  ^-  [buoy rode crow]
  =,  dejs:format
  %.  jon
  %-  ot
  :~  ses+so  :: expexts the session id string,
      com+so  :: and the component's key
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
++  make-com-subscription-card
  |=  act=?(%add %del)
  ^-  card
  =/  des  q.byk.bowl
  :*  %pass  /mast/deck  %arvo  %c  %warp  our.bowl  des
      ?-  act
        %add  [~ %next %z da+now.bowl /com]
        %del  ~
      ==
  ==
::
++  make-resource-subscription-card
  |=  [act=?(%add %del) paf=path]
  ^-  card
  =/  wir  [%mast %res paf]
  ?-  act
    %add  [%pass wir %agent [our.bowl dap.bowl] %watch [%x paf]]
    %del  [%pass wir %agent [our.bowl dap.bowl] %leave ~]
  ==
::
++  handle-component-res
  |=  [src=ship ses=buoy res=(list tide)]
  ^+  cor
  ?~  res  cor
  ?-  -.i.res
    ::
      %add
    =/  sus  (~(get by navy) q.i.res)
    ?^  sus
      =/  bub  (~(get by u.sus) [src ses])
      %=  $
        res  t.res
        navy
          %+  ~(put by navy)  q.i.res
          ?~  bub
            %+  ~(put by u.sus)  [src ses]  (silt p.i.res ~)
          %+  ~(put by u.sus)  [src ses]  (~(put in u.bub) p.i.res)
      ==
    =.  cor  (emit (make-resource-subscription-card [%add q.i.res]))
    %=  $
      res  t.res
      navy  (~(put by navy) q.i.res (malt [[src ses] (silt p.i.res ~)] ~))
    ==
    ::
      %del
    =/  sus  (~(get by navy) q.i.res)
    ?~  sus
      %=  $
        res  t.res
      ==
    =.  u.sus
      =/  bub  (~(get by u.sus) [src ses])
      ?~  bub  u.sus
      =.  u.bub  (~(del in u.bub) p.i.res)
      ?^  u.bub  (~(put by u.sus) [src ses] u.bub)
      %-  ~(del by u.sus)  [src ses]
    ?^  u.sus
      %=  $
        res  t.res
        navy  (~(put by navy) q.i.res u.sus)
      ==
    =.  cor  (emit (make-resource-subscription-card [%del q.i.res]))
    %=  $
      res  t.res
      navy  (~(del by navy) q.i.res)
    ==
    ::
  ==
::
++  make-component-res
  |=  [act=?(%add %del) rod=rode bom=boom pol=pool]
  ^-  (list tide)
  %+  murn  bom
  |=  [nam=@tas mak=@tas]
  =/  paf  (~(get by pol) nam)
  ?~  paf  ~
  :^  ~  act  rod  u.paf
::
++  load-deck
  =/  fis  .^((list path) %ct (bem /com))
  |-  ^-  ^deck
  ?~  fis  deck
  ~&  (bem i.fis)
  =/  fil  .^(vase %ca (bem i.fis))
  =/  huk  `hook`(rear (snip i.fis))
  =/  mat  (mole |.(!<(mast fil)))
  ?^  mat
    %=  $
      fis  t.fis
      deck  (~(put by deck) huk u.mat)
    ==
  %=  $
    fis  t.fis
  ==
::
++  del-component-state
  |=  $=  act
      $%  [%bound bas=knot]
          [%clean kil=(list [src=ship ses=buoy])]
          [%all ~]
      ==
  =/  guf
    ^-  (list [key=[src=ship ses=buoy] val=[rop=rope yel=isle]])
    %~  tap  by  gulf
  |-  ^+  cor
  ?~  guf  cor
  ?.  ?|  ?=(%all -.act)
          &(?=(%bound -.act) =(bas.act bas.rop.val.i.guf))
          &(?=(%clean -.act) ?=(^ (find ~[key.i.guf] kil.act)))
      ==
    %=  $
      guf  t.guf
    ==
  =/  cos=(list [rod=rode cov=cove])  ~(tap by yel.val.i.guf)
  |-  ^+  cor
  ?~  cos
    %=  ^$
      guf  t.guf
    ==
  =.  cor
    %^  handle-component-res  src.key.i.guf  ses.key.i.guf
    %:  make-component-res  %del  rod.i.cos  bom.cov.i.cos  res.lin.cov.i.cos
    ==
  =.  gulf  (~(del by gulf) key.i.guf)
  %=  $
    cos  t.cos
  ==
::
++  init
  ^+  cor
  =^  caz  you  ~(on-init you bowl)
  =.  cor  set:cleanup-timer
  =.  deck  load-deck
  %-  emil
  :*  (make-com-subscription-card %add)
      caz
  ==
::
++  save
  ^-  vase
  !>  [%mast `state-n`-:state(deck ~) ~(on-save you bowl)]
::
++  load
  |=  vaz=vase
  ^+  cor
  ?.  ?=([%mast *] +.vaz)
    =^  caz  you  (~(on-load you bowl) vaz)
    %-  emil  caz
  =+  !<  [%mast maz=state-n nez=vase]  vaz
  =^  caz  you  (~(on-load you bowl) nez)
  =.  cor  (emil caz)
  ?-  -.maz
    ::
      %state-0
    =.  -.state  maz
    :: cleanup previous component state
    =.  cor  (del-component-state [%all ~])
    =.  cor  reset:cleanup-timer
    =.  deck  load-deck
    %-  emit  (make-com-subscription-card %add)
    ::
  ==
::
++  peek
  |=  poe=(pole @ta)
  ^-  (unit (unit cage))
  %-  ~(on-peek you bowl)  poe
::
++  watch
  |=  poe=(pole @ta)
  ^+  cor
  ?:  ?=([%mast-tui *] poe)  (tui-watch-handler poe)
  =^  caz  you  (~(on-watch you bowl) poe)
  %-  emil  caz
::
++  leave
  |=  poe=(pole @ta)
  ^+  cor
  ?:  ?=([%mast-tui *] poe)  (tui-leave-handler poe)
  =^  caz  you  (~(on-leave you bowl) poe)
  %-  emil  caz
::
++  fail
  |=  [tem=term tan=tang]
  ^+  cor
  =^  caz  you  (~(on-fail you bowl) tem tan)
  %-  emil  caz
::
++  arvo
  |=  [=wire sign=sign-arvo]
  ^+  cor
  ?.  ?=([%mast *] wire)
    =^  caz  you  (~(on-arvo you bowl) wire sign)
    %-  emil  caz
  ?+  sign  cor
    ::
      [%clay %writ *]
    ?+  wire  cor
      ::
        [%mast %deck ~]
      :: delete all component state
      =.  cor  (del-component-state [%all ~])
      :: reload components on change to a desk's /com
      =.  deck  load-deck
      %-  emit  (make-com-subscription-card %add)
      ::
    ==
    ::
      [%behn %wake *]
    ?+  wire  cor
      ::
        [%mast %cleanup ~]
      =.  cor  set:cleanup-timer
      ?^  error.sign  cor
      =/  nel  .^(channel-state:eyre %e (bak %channel-state))
      =/  kil
        %+  skip  ~(tap in ~(key by gulf))
        |=  [s=ship b=buoy]
        %-  ~(has by session.nel)  `@t`b
      %-  del-component-state  [%clean kil]
      ::
    ==
    ::
  ==
::
++  poke
  |=  [=mark =vase]
  ^+  cor
  ?+  mark
    ::
    =^  caz  you  (~(on-poke you bowl) mark vase)
    %-  emil  caz
    ::
      %mast-tui  (tui-poke-handler mark vase)
    ::
      %mast-bind
    ?>  =(our.bowl src.bowl)
    =/  bid  !<  bind  vase
    ?:  (~(has by dock) p.bid)
      ~&  >>>  "%mast-bind failed: /{(trip p.bid)} already exists"
      !!
    =.  dock  (~(put by dock) bid)
    ~&  >  "%mast-bind: /{(trip p.bid)} --> {(trip com.q.bid)}"
    %-  emit  (bind-eyre-url /[p.bid])
    ::
      %mast-unbind
    ?>  =(our.bowl src.bowl)
    =/  not  !<  knot  vase
    =/  duk  (~(get by dock) not)
    ?~  duk
      ~&  >>  "%mast-unbind: /{(trip not)} is already unbound"
      !!
    =.  cor  (del-component-state [%bound not])
    =.  dock  (~(del by dock) not)
    ~&  >  "%mast-unbind: /{(trip not)} unbound"
    %-  emit  (unbind-eyre-url /[not])
    ::
      %mast-action
    ?>  ?&  =(our.bowl src.bowl)
            =(/gall/[dap.bowl] sap.bowl)
        ==
    =/  act  !<(gull vase)
    ?-  -.act
      ::
        %navigate
      =/  jon  (swig [%navigate (print-url to.act)])
      %-  emit  (make-channel-card src.act ses.act jon)
      ::
    ==
    ::
      %handle-http-request
    =+  !<  [rid=@ta req=inbound-request:eyre]  vase
    ?+  method.request.req
      ::
      :: fall through to nested agent
      =^  caz  you  (~(on-poke you bowl) mark vase)
      %-  emil  caz
      ::
        %'GET'
      =/  rup  (parse-url url.request.req)
      ?~  rup
        %-  emil
        %^  make-direct-http-cards  rid  [400 ['Content-Type' 'text/plain'] ~]
        :-  ~
        %-  as-octs:mimes:html  '400 Bad Request: Malformed URL'
      =/  duk  (~(get by dock) bas.u.rup)
      ?~  duk
        :: fall through to nested agent if binding not found
        =^  caz  you  (~(on-poke you bowl) mark vase)
        %-  emil  caz
      =/  ses  `buoy`(crip ((d-co:co 1) now.bowl))
      =/  ui-core  (ui-abed:ui %& src.bowl ses u.rup)
      =^  [sal=manx res=(set tide)]  ui-core  ui-moor:ui-core
      =.  gulf  ui-abet:ui-core
      =.  cor  (handle-component-res src.bowl ses ~(tap in res))
      %-  emil
      %^  make-direct-http-cards  rid  [200 ['Content-Type' 'text/html'] ~]
      :-  ~
      %-  as-octt:mimes:html
      %-  en-xml:html  sal
      ::
    ==
    ::
      %json
    =+  !<  jon=json  vase
    ?.  ?&  ?=(%a -.jon)
            ?=(^ p.jon)
            ?=(^ t.p.jon)
            =([%s 'mast'] i.p.jon)
        ==
      :: fall through to nested agent
      =^  caz  you  (~(on-poke you bowl) mark vase)
      %-  emil  caz
    ?+  i.t.p.jon  !!
      ::
        [%s %'event']
      ?>  ?=(^ t.t.p.jon)
      =/  [ses=buoy rod=rode cro=crow]  (parse-channel-data i.t.t.p.jon)
      =^  caz  you  (ui-sway:(ui-abed:ui %| src.bowl ses) rod cro)
      %-  emil  caz
      ::
        [%s %'kill']
      ?>  ?=([[%s @] ~] t.t.p.jon)
      %-  del-component-state  [%clean [[src.bowl p.i.t.t.p.jon] ~]]
      ::
    ==
    ::
  ==
::
++  agent
  |=  [wir=(pole @ta) sin=sign:agent:gall]
  ^+  cor
  ?:  ?=([%mast-tui *] wir)  (tui-fact-handler wir)
  ?.  ?=([%mast *] wir)
    =^  caz  you  (~(on-agent you bowl) wir sin)
    %-  emil  caz
  ?+  wir  cor
    ::
      [%mast %res res=*]
    ?+  -.sin  cor
      ::
        %fact
      =/  sus  (~(get by navy) res.wir)
      ?~  sus
        %-  emit  (make-resource-subscription-card [%del res.wir])
      =/  gus
        ^-  (list [[src=ship ses=buoy] dat=(set rode)])
        %~  tap  by  u.sus
      |-  ^+  cor
      ?~  gus  cor
      =/  cus  ~(tap in dat.i.gus)
      |-  ^+  cor
      ?~  cus  ^$(gus t.gus)
      =/  ui-core  (ui-abed:ui %| src.i.gus ses.i.gus)
      =^  [jon=json res=(set tide)]  ui-core  (ui-furl:ui-core i.cus)
      =.  gulf  ui-abet:ui-core
      =?  cor  .?(res)  (handle-component-res src.i.gus ses.i.gus ~(tap in res))
      =?  cor  .?(jon)  (emit (make-channel-card src.i.gus ses.i.gus jon))
      %=  $
        cus  t.cus
      ==
      ::
    ==
    ::
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
      %&
        %_  ui-core
          src  s.p
          ses  b.p
          rop  r.p
          yel  ~
        ==
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
  :: ++ui-moor
  :: render from the root
  ++  ui-moor
    ^-  [[manx (set tide)] _ui-core]
    :: the component key for the root is null
    =/  rod  *rode
    =/  lin  (~(got by dock) bas.rop)
    =/  com  (~(got by deck) com.lin)
    =/  doc  ~(sail com (make-hull boom.com lin))
    :: assert that the product of the sail arm
    :: is a complete document of the following structure:
    ?.  ?&  ?=([* * ~] c.doc)
            ?=(%html n.g.doc)
            ?=(%head n.g.i.c.doc)
            ?=(%body n.g.i.t.c.doc)
        ==
      ~&  >>>  [%malformed-root-component com.lin]
      !!
    =/  [sal=manx wak=wake]  (build-component-branch rod lin)
    :: the root element after building should be %body
    ?>  ?=(%body n.g.sal)
    =.  yel  (~(uni by yel) new.wak)
    :_  ui-core
    :_  res.wak
    %_  doc
      a.g
        :~  [%our +:(scow %p our.bowl)]
            [%app (trip dap.bowl)]
            [%ses (trip `@t`ses)]
            [%sub (spud (make-client-sub-path src ses))]
        ==
      c.i.c  [script-element c.i.c.doc]
      i.t.c  sal
    ==
  ::
  :: ++ui-furl
  :: rerender and diff a component
  ++  ui-furl
    |=  rod=rode
    ^-  [[json (set tide)] _ui-core]
    =/  cov  (~(got by yel) rod)
    =/  com  (~(got by deck) com.lin.cov)
    =/  cun  +(dif.cov)
    =/  new  (process-sail rod cun ~(sail com (make-hull boom.com lin.cov)))
    =/  dif  (luff [aft.cov ~] [new ~])
    ?~  q.dif
      :-  ~^~  ui-core
    =/  jon  (swig [%diff rod cun q.dif])
    =.  yel
      %.  add.p.dif
      %~  uni  by
      %+  ~(put by yel)  rod
      %_  cov
        aft  new
        dif  cun
      ==
    =^  res=(set tide)  yel
      =/  res  *(set tide)
      =/  ros  ~(tap in del.p.dif)
      |-  ^-  [(set tide) isle]
      ?~  ros  [res yel]
      =/  cuv  (~(get by yel) i.ros)
      ?~  cuv  $(ros t.ros)
      %=  $
        ros  t.ros
        res  (~(gas in res) (make-component-res %del i.ros bom.u.cuv res.lin.u.cuv))
        yel  (~(del by yel) i.ros)
      ==
    :_  ui-core
    :-  jon  (~(uni in res.p.dif) res)
  ::
  :: ++ui-sway
  :: apply an event
  ++  ui-sway
    |=  [rod=rode cro=crow]
    ^-  [(list card) _you]
    =/  cov  (~(got by yel) rod)
    =/  com  (~(got by deck) com.lin.cov)
    =/  blo  (~(spar com (make-hull bom.cov lin.cov)) cro)
    =/  caz  *(list card)
    =/  pof  ~(. you spoof-bowl)
    |-  ^+  [caz you]
    ?~  blo  [caz you]
    ?:  =(%mast-action p.i.blo)
      %=  $
        blo  t.blo
        caz  [[%pass /mast/action %agent [our.bowl dap.bowl] %poke i.blo] caz]
      ==
    =^  cuz  you  (on-poke:pof i.blo)
    %=  $
      blo  t.blo
      caz  (weld caz cuz)
    ==
  ::
  :: ++parse-component-element
  :: extract component data from a component element;
  :: the format for a component element is defined in
  :: the ++make arm in /sur/mast/hoon
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
  :: ++process-sail
  :: process a component's rendered sail, mainly adding keys
  ++  process-sail
    |=  [com-key=@t com-dif=@ sal=manx]
    ^-  manx
    =/  n  0
    =/  prev-key   (trip com-key)
    =/  pos-key  *(list @)
    :: if rendered from a root component,
    :: make %body the root element
    =?  sal  =(%html n.g.sal)
      ?>  ?=([* [[%body *] *] *] c.sal)
      i.t.c.sal
    :: add a mast component attribute to the root
    :: with the current diff counter as its value
    =.  a.g.sal  [[%mast ((d-co:co 1) com-dif)] a.g.sal]
    |-  ^-  manx
    :: temporary: if text node, add text node wrapper
    =?  sal  =(%$ n.g.sal)  ;t-  ;+  sal  ==
    =/  found-key
      ^-  tape
      %+  roll  a.g.sal
      |=  [[k=mane v=tape] a=tape]
      ?:  =(%key k)  v  a
    :: build the current element's key:
    =/  this-key
      ^-  tape
      :: for the root element of this component, the key is given:
      ?:  =(0 n)  (trip com-key)
      %-  (v-co:co 1)
      %-  mug
      :: for each of these cases
      :: the position key needs to drop this element's index
      :: so that it is determined by a third part
      :: instead of its own position
      ?:  =(%mast n.g.sal)
        :+  prev-key
            ?.(.?(pos-key) ~ +.pos-key)
            (parse-component-element sal)
      ?:  =(%client-state n.g.sal)
        :+  prev-key
            ?.(.?(pos-key) ~ +.pos-key)
            a.g.sal
      ?^  found-key
        :+  prev-key
            ?.(.?(pos-key) ~ +.pos-key)
            found-key
      :: else the key is only positional
      :-  prev-key
          pos-key
    =.  a.g.sal
      :-  [%key this-key]
      ?~  found-key  a.g.sal
      %+  skip  a.g.sal
      |=  [k=mane v=tape]
      .=  %key  k
    :: don't recurse for these elements:
    ?:  ?|  =(%mast n.g.sal)  =(%client-state n.g.sal)  =(%t- n.g.sal)
            =(%input n.g.sal)   =(%textarea n.g.sal)
            =(%script n.g.sal)  =(%img n.g.sal)
            =(%link n.g.sal)    =(%hr n.g.sal)
            =(%meta n.g.sal)    =(%base n.g.sal)
        ==
      sal
    :: process child elements, giving them the next key state
    :-  g.sal
    =:  prev-key  ?^  found-key  this-key  prev-key
        pos-key  ?^  found-key  ~  pos-key
      ==
    %+  spun  c.sal
    |=  [m=manx i=@]
    :_  +(i)
    %=  ^$
      n  +(n)
      sal  m
      pos-key  [i pos-key]
    ==
  ::
  ++  spoof-bowl
    %_  bowl
      src  src
      sap  /gall/[dap.bowl]
    ==
  ::
  ++  hydrate-component
    |=  [bom=boom res=pool]
    ^-  gale
    :: load the nested agent with a modified bowl
    =/  pof  ~(. you spoof-bowl)
    %-  malt
    %+  murn  bom
    |=  [nam=@tas mak=@tas]
    ^-  (unit [term path vase])
    =/  paf  (~(get by res) nam)
    ?~  paf  ~
    =/  dat  (on-peek:pof [%x u.paf])
    ?:  ?|  ?=(~ dat)
            ?=(~ u.dat)
        ==
      ~&  >>>  [%mast dap.bowl %scry-failed `path`[%x u.paf]]
      ~
    ?:  =(p.u.u.dat mak)
      :-  ~
      :+  nam
          u.paf
          q.u.u.dat
    =/  tub  .^(tube:clay %cc (bem /[p.u.u.dat]/[mak]))
    :-  ~
    :+  nam
        u.paf
        (tub q.u.u.dat)
  ::
  ++  make-hull
    |=  [bom=boom lin=line]
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
        (hydrate-component bom res.lin)
    ==
  ::
  ++  build-component-branch
    |=  [rod=rode lin=line]
    ^-  [manx wake]
    =/  [new=? mal=marl cov=cove]
      =/  cuv  (~(get by yel) rod)
      ?^  cuv
        :+  |
            [aft.u.cuv ~]
            u.cuv
      =/  dif  0
      =/  com  (~(got by deck) com.lin)
      =/  sal  (process-sail rod dif ~(sail com (make-hull boom.com lin)))
      :+  &
          [sal ~]
      :*  dif
          boom.com
          sal
          lin
      ==
    =-  ?>  ?=(^ p)
        :-  i.p
        ?.  new  q
        :-  (~(gas in res.q) (make-component-res %add rod bom.cov res.lin))
            (~(put by new.q) rod cov)
    |-  ^-  (pair marl wake)
    %^  spin  mal  *wake
    |=  [m=manx a=wake]
    =^  b=wake  m
      ?.  =(%mast n.g.m)
        =+  ^$(mal c.m)
        :-  q
            m(c p)
      =<  [q p]
      ^-  (pair manx wake)
      %=  ^^$
        rod  (getv %key a.g.m)
        lin  (parse-component-element m)
      ==
    :-  m
    :-  (~(uni in res.a) res.b)
        (~(uni by new.a) new.b)
  ::
  ++  handle-diff-branch-add
    |=  sal=manx
    ^-  [wake manx]
    =/  mal  `marl`[sal ~]
    =-  ?>  ?=(^ p)  [q i.p]
    |-  ^-  (pair marl wake)
    %^  spin  mal  *wake
    |=  [m=manx a=wake]
    =^  b=wake  m
      ?.  =(%mast n.g.m)
        =+  ^$(mal c.m)
        :-  q
            m(c p)
      =<  [q p]
      ^-  (pair manx wake)
      %+  build-component-branch
          (getv %key a.g.m)
          (parse-component-element m)
    :-  m
    :-  (~(uni in res.a) res.b)
        (~(uni by new.a) new.b)
  ::
  ++  handle-diff-branch-dels
    |=  mal=marl
    ^-  (set rode)
    %+  roll  mal
    |=  [m=manx a=(set rode)]
    ?.  =(%mast n.g.m)
      %-  ~(uni in a)
      %=  ^$
        mal  c.m
      ==
    =/  rod  `rode`(getv %key a.g.m)
    =/  cuv  (~(get by yel) rod)
    ?~  cuv  a
    %-  ~(uni in (~(put in a) rod))
    %=  ^$
      mal  c.aft.u.cuv
    ==
  ::
  ++  luff
    |=  [old=marl new=marl]
    =|  i=@ud
    =|  pkey=@t
    =|  acc=diff
    |-  ^-  diff
    ?~  new
      ?~  old
        acc
      ?:  =(%skip- n.g.i.old)
        %=  $
          old  t.old
        ==
      %_  acc
        del.p
          %-  ~(uni in del.p.acc)
          %-  handle-diff-branch-dels  old
        q
          :_  q.acc
          :*  %delete
              (turn old |=(m=manx (getv %key a.g.m)))
          ==
      ==
    ?:  =(%$ n.g.i.new)
      acc
    ?:  &(?=(^ old) =(%skip- n.g.i.old))
      %=  $
        old  t.old
      ==
    ?:  =(%move- n.g.i.new)
      %=  $
        new  t.new
        i    +(i)
        q.acc
          %+  snoc  q.acc
          :*  %move
              (getv %key a.g.i.new)
              (getv %i a.g.i.new)
          ==
      ==
    =|  j=@ud
    =/  jold=marl  old
    =/  nkey=[n=mane k=@t]  [n.g.i.new (getv %key a.g.i.new)]
    |-  ^-  diff
    ?~  new
      !!
    ?~  jold
      %=  ^$
        new  t.new
        i    +(i)
        acc
          =^  wak  i.new  (handle-diff-branch-add i.new)
          %_  acc
            res.p  (~(uni in res.p.acc) res.wak)
            add.p  (~(uni by add.p.acc) new.wak)
            q
              %+  snoc  q.acc
              :*  %new
                  pkey
                  (crip ((d-co:co 1) i))
                  (crip (en-xml:html i.new))
              ==
          ==
      ==
    ?~  old
      !!
    ?:  =(%skip- n.g.i.jold)
      %=  $
        jold  t.jold
        j     +(j)
      ==
    ?:  =(nkey [n.g.i.jold (getv %key a.g.i.jold)])
      ?.  =(0 j)
        =|  n=@ud
        =/  nnew=marl  new
        =/  okey=[n=mane k=@t]  [n.g.i.old (getv %key a.g.i.old)]
        |-  ^-  diff
        ?~  nnew
          %=  ^^$
            old  (snoc t.old i.old)
          ==
        ?:  =(%move- n.g.i.nnew)
          %=  $
            nnew  t.nnew
            n     +(n)
          ==
        =/  nnky=[n=mane k=@t]  [n.g.i.nnew (getv %key a.g.i.nnew)]
        ?.  =(okey nnky)
          %=  $
            nnew  t.nnew
            n     +(n)
          ==
        ?:  (gte n j)
          =/  jib  (jibe n.g.i.nnew a.g.i.old a.g.i.nnew)
          %=  ^^$
            old   c.i.old
            new   c.i.nnew
            pkey  k.nnky
            i     0
            acc
              %=  ^^$
                old  t.old
                new
                  %^  snap  `marl`new  n
                  ^-  manx
                  ;move-(i ((d-co:co 1) (add n i)), key (trip k.nnky));
                q.acc
                  ?:  &(?=(~ del.jib) ?=(~ new.jib))  q.acc
                  :_  q.acc
                  :*  %change-attr
                      k.nnky
                      jib
                  ==
              ==
          ==
        =/  jib  (jibe n.g.i.new a.g.i.jold a.g.i.new)
        %=  ^^$
          old   c.i.jold
          new   c.i.new
          pkey  k.nkey
          i     0
          acc
            %=  ^^$
              old  (snap `marl`old j `manx`;skip-;)
              new  t.new
              i    +(i)
              q.acc
                =.  q.acc
                  %+  snoc  q.acc
                  :*  %move
                      k.nkey
                      (crip ((d-co:co 1) i))
                  ==
                ?:  &(?=(~ del.jib) ?=(~ new.jib))  q.acc
                :_  q.acc
                :*  %change-attr
                    k.nkey
                    jib
                ==
            ==
        ==
      ?:  =(%t- n.g.i.new)
        ?:  ?&  ?=(^ c.i.old)  ?=(^ c.i.new)
                ?=(^ a.g.i.c.i.old)  ?=(^ a.g.i.c.i.new)
                =(v.i.a.g.i.c.i.old v.i.a.g.i.c.i.new)
            ==
          %=  ^$
            old  t.old
            new  t.new
            i    +(i)
          ==
        =/  txt=@t
          ?.  &(?=(^ c.i.new) ?=(^ a.g.i.c.i.new))  ''
          %-  crip  v.i.a.g.i.c.i.new
        %=  ^$
          old  t.old
          new  t.new
          i    +(i)
          q.acc
            :_  q.acc
            :*  %text
                (getv %key a.g.i.new)
                txt
            ==
        ==
      =/  jib  (jibe n.g.i.new a.g.i.old a.g.i.new)
      %=  ^$
        old   c.i.old
        new   c.i.new
        pkey  k.nkey
        i     0
        acc
          %=  ^$
            old  t.old
            new  t.new
            i    +(i)
            q.acc
              ?:  &(?=(~ del.jib) ?=(~ new.jib))  q.acc
              :_  q.acc
              :*  %change-attr
                  k.nkey
                  jib
              ==
          ==
      ==
    %=  $
      jold  t.jold
      j     +(j)
    ==
  ::
  :: ++jibe
  :: diff an attribute list.
  :: used in ++luff.
  ++  jibe
    |=  [nn=mane om=mart nm=mart]
    =|  $=  acc
        $:  del=(list @t)
            new=(list [k=@t v=@t])
        ==
    ?:  =(%mast nn)  acc
    |-  ^+  acc
    ?~  nm
      ?~  om
        acc
      %_    acc
          del
        %+  turn  om
        |=  [n=mane *]
        `@t`?>(?=(@ n) n)
      ==
    =|  i=@ud
    =/  com=mart  om
    |-  ^+  acc
    ?~  nm
      !!
    ?~  com
      %=  ^$
        nm  t.nm
        new.acc
          :_  new.acc
          :-  `@t`?>(?=(@ n.i.nm) n.i.nm)
              (crip v.i.nm)
      ==
    ?~  om
      !!
    ?:  =(n.i.com n.i.nm)
      ?:  ?|  =(v.i.com v.i.nm)
              =(%mast n.i.nm)  :: skip if mast component attribute
          ==
        %=  ^$
          om  (oust [i 1] (mart om))
          nm  t.nm
        ==
      %=  ^$
        om   (oust [i 1] (mart om))
        nm   t.nm
        new.acc
          :_  new.acc
          :-  `@t`?>(?=(@ n.i.nm) n.i.nm)
              (crip v.i.nm)
      ==
    %=  $
      com  t.com
      i    +(i)
    ==
  ::
  :: ++getv
  :: gets a value from mart by key.
  ++  getv
    |=  [t=@tas m=mart]
    ^-  @t
    ?~  m  ''
    ?:  =(n.i.m t)
      (crip v.i.m)
    $(m t.m)
  ::
  --
::
:: ++swig
:: client update to json
++  swig
  |=  gog=grog
  ^-  json
  ?-  -.gog
    ::
      %navigate
    :-  %s  to.gog
    ::
      %diff
    =;  dif
      :-  %o
      %-  my
      :~  ['p' [%s component.gog]]
          ['q' [%n (crip ((d-co:co 1) counter.gog))]]
          ['r' [%a dif]]
      ==
    ^-  (list json)
    %+  turn  diff.gog
    |=  mes=mess
    ^-  json
    :-  %o
    %-  my
    ?-  -.mes
      %new
        :~  ['p' [%s 'n']]
            ['q' [%s parent-key.mes]]
            ['r' [%n index.mes]]
            ['s' [%s data.mes]]
        ==
      %delete
        :~  ['p' [%s 'd']]
            ['q' [%a (turn keys.mes |=(k=@t s+k))]]
        ==
      %move
        :~  ['p' [%s 'm']]
            ['q' [%s key.mes]]
            ['r' [%n index.mes]]
        ==
      %change-attr
        :~  ['p' [%s 'c']]
            ['q' [%s key.mes]]
            ['r' [%a (turn del.mes |=(k=@t s+k))]]
            ['s' [%a (turn new.mes |=([k=@t v=@t] [%a s+k s+v ~]))]]
        ==
      %text
        :~  ['p' [%s 't']]
            ['q' [%s container-key.mes]]
            ['r' [%s data.mes]]
        ==
    ==
    ::
  ==
::    :::    ::
  ::  TUI  ::
::    :::    ::
++  ulus
  |%
  +$  component-event
    $:  session-id=@t
        route=rope
        com-key=(list @t)
        =path
        data=(map @t @t)
    ==
  +$  update  (lest update-card)
  +$  update-card
    $%  [%element p=manx]
        :: [%set-select p=path]
        [%set-scroll-position p=?(%c %p) q=@ r=path]
    ==
  --
::
++  tui-make-update-card
  |=  [src=ship ses=buoy zez=buoy dat=update:ulus]
  ^-  card
  =/  paf  /mast-tui/[(scot %p src)]/[ses]
  :*  %give  %fact  [paf ~]
      %json  !>(dat)
  ==
::
++  tui-watch-handler
  |=  poe=(pole @ta)
  ^+  cor
  :: /mast-tui/session-id/uw-jam-of-rope
  ?>  ?=([%mast-tui ses=@t zez=@t ~] poe)
  =/  rop  ;;(rope (cue (slav %uw zez.poe)))
  =/  tui-core  (tui-abed:tui [%& src.bowl ses.poe zez.poe rop])
  =^  [caz=(list card) sal=manx]  tui-core  tui-full:tui-core
  %-  emil
      :-  (tui-make-update-card src.bowl ses.poe zez.poe [[%element sal] ~])
          caz
::
++  tui-leave-handler
  |=  poe=(pole @ta)
  ^+  cor
  ?>  ?=([%mast-tui ses=@t zez=@t ~] poe)
  =/  tui-core  (tui-abed:tui [%| src.bowl ses.poe zez.poe])
  =^  caz=(list card)  tui-core  tui-kill:tui-core
  =.  tui-gulf  (~(del by tui-gulf) [src.bowl ses.poe zez.poe])
  %-  emil  caz
::
++  tui-fact-handler
  |=  wir=(pole @ta)
  ^+  cor
  :: /mast-tui/res/ship/session-id/component-ancestry-keys...
  ?>  ?=([%mast-tui %res sip=@ta ses=@t zez=@t ros=*] wir)
  =/  who  (slav %p sip.wir)
  =/  tui-core  (tui-abed:tui [%| who ses.wir zez.wir])
  =^  [caz=(list card) sal=manx]  tui-core
      %-  tui-update:tui-core
          ros.wir
  %-  emil
      :-  (tui-make-update-card who ses.wir zez.wir [[%element sal] ~])
          caz
::
++  tui-poke-handler
  |=  [mak=mark vaz=vase]
  ^+  cor
  ?>  ?=(%mast-tui mak)
  =/  eve  !<(component-event:ulus vaz)
  =/  zez  (scot %uw (jam route.eve))
  =^  caz  you  (tui-event:(tui-abed:tui [%| src.bowl session-id.eve zez]) com-key.eve path.eve data.eve)
  %-  emil  caz
::
++  tui
  |_  [src=ship ses=buoy zez=buoy rop=rope yel=tui-isle]
  ++  tui-core  .
  ++  tui-abet  (~(put by tui-gulf) [src ses zez] [rop yel])
  ++  tui-abed
    |=  %+  each
            [s=ship b=buoy z=buoy r=rope]
            [s=ship b=buoy z=buoy]
    ?-  +<-
    %&
        :: open a new session
        =/  l  (~(got by tui-dock) bas.r.p)
        %_  tui-core
          src  s.p
          ses  b.p
          zez  z.p
          rop  r.p
          yel  [l ~]
        ==
    %|
        :: get an existing session
        =/  q=[r=rope y=tui-isle]  (~(got by tui-gulf) [s.p b.p z.p])
        %_  tui-core
          src  s.p
          ses  b.p
          zez  z.p
          rop  r.q
          yel  y.q
        ==
    ==
  ::
  ++  tui-full
    ^-  [[(list card) manx] _tui-core]
    :: the root component's key is null
    =/  key  ''
    =/  [yul=tui-isle sal=manx]  (render key p.yel)
    :_  tui-core(yel yul)
    :-  (diff-resources [key ~] yel yul)
        sal
  ::
  ++  tui-kill
    ^-  [(list card) _tui-core]
    =/  key  ''
    =/  [yul=tui-isle sal=manx]  (render key p.yel)
    =/  kil  [p.yel ~]
    :-  (diff-resources [key ~] yel kil)
        tui-core(yel kil)
  ::
  ++  tui-update
    |=  ros=(list rode)
    ^-  [[(list card) manx] _tui-core]
    =/  old  (get-tui-isle ?>(?=(^ ros) ros))
    =/  [new=tui-isle sal=manx]  (render (rear ros) p.old)
    :_  tui-core(yel (set-tui-isle ?>(?=(^ ros) ros) new))
    :-  (diff-resources ros old new)
        sal
  ::
  ++  tui-event
    |=  [ros=(list rode) cro=crow]
    ^-  [(list card) _you]
    =/  yul  (get-tui-isle ?>(?=(^ ros) ros))
    =/  com  (~(got by tui-deck) com.p.yul)
    =/  blo  (~(spar com (make-hull boom.com p.yul)) cro)
    =/  caz  *(list card)
    =/  pof  ~(. you spoof-bowl)
    |-  ^+  [caz you]
    ?~  blo  [caz you]
    ?:  =(%mast-tui-action p.i.blo)
      %=  $
        blo  t.blo
        caz  [[%pass /mast/action %agent [our.bowl dap.bowl] %poke i.blo] caz]
      ==
    =^  cuz  you  (on-poke:pof i.blo)
    %=  $
      blo  t.blo
      caz  (weld caz cuz)
    ==
  ::
  ++  get-tui-isle
    |=  ros=(lest rode)
    ^-  tui-isle
    ?~  t.ros  yel
    %=  $
        ros  t.ros
        yel  (~(got by q.yel) i.ros)
    ==
  ::
  ++  set-tui-isle
    |=  [ros=(lest rode) yul=tui-isle]
    ^-  tui-isle
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
    |=  [rod=rode lin=line]
    ^-  [tui-isle manx]
    :: rod is the key for the current component
    :: passed in on iteration of render
    =/  com  (~(got by tui-deck) com.lin)
    =/  mal  `marl`[~(sail com (make-hull boom.com lin)) ~]
    =-  ?>  ?=(^ p)
        :-  [lin q]
        :: add this component's key to the root element as a %mast attribute
        %_  i.p
            a.g  [[%mast (trip rod)] a.g.i.p]
        ==
    |-  ^-  (pair marl (map rode tui-isle))
    %^  spin
        mal
        *(map rode tui-isle)
    |=  [m=manx a=(map rode tui-isle)]
    =^  b  m
        ^-  [(map rode tui-isle) manx]
        ?.  =(%mast n.g.m)
            =+  ^$(mal c.m)
            :-  q
                m(c p)
        =/  l  (parse-component-element m)
        :: make a key for the nested component
        :: using its parent's key and its line
        =/  k  (crip ((v-co:co 1) (mug [rod l])))
        =^  i  m
            %=  ^^$
                rod  k
                lin  l
            ==
        :-  [[k i] ~ ~]
            m
    :-  m
        (~(uni by a) b)
  ::
  ++  diff-resources
    |=  [unc=(list rode) old=tui-isle new=tui-isle]
    |^
    ^-  (list card)
    %+  weld  (del-or-add %del (~(dif by q.old) q.new))
    %+  weld  (del-or-add %add (~(dif by q.new) q.old))
    ^-  (list card)
    %-  ~(rep in ~(key by (~(int by q.old) q.new)))
    |=  [r=rode a=(list card)]
    ^-  (list card)
    %+  weld  a
    %=  ^$
        unc  (snoc unc r)
        old  (~(got by q.old) r)
        new  (~(got by q.new) r)
    ==
    ::
    ++  del-or-add
    |=  [wat=?(%del %add) dis=(map rode tui-isle)]
    ^-  (list card)
    %-  ~(rep by dis)
    |=  [[k=rode v=tui-isle] a=(list card)]
    =.  unc  (snoc unc k)
    %+  weld  a
    %+  weld
        %+  turn  ~(val by res.p.v)
        |=  paf=path
        %+  tui-make-resource-subscription-card
            wat
            paf
    %=  ^$
        dis  q.v
    ==
    ::
    ++  tui-make-resource-subscription-card
    |=  [act=?(%add %del) paf=path]
    ^-  card
    :: /mast-tui/res/ship/session-id/component-ancestry-keys...
    =/  wir  [%mast-tui %res (scot %p src) ses unc]
    ?-  act
        %add  [%pass wir %agent [our.bowl dap.bowl] %watch [%x paf]]
        %del  [%pass wir %agent [our.bowl dap.bowl] %leave ~]
    ==
    --
  ::
  :: :: :: :: :: :: ::
  :: copied from +ui:
  :: :: :: :: :: :: ::
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
    |=  [bom=boom lin=line]
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
        (hydrate-component bom res.lin)
    ==
  ::
  ++  hydrate-component
    |=  [bom=boom res=pool]
    ^-  gale
    :: load the nested agent with a modified bowl
    =/  pof  ~(. you spoof-bowl)
    %-  malt
    %+  murn  bom
    |=  [nam=@tas mak=@tas]
    ^-  (unit [term path vase])
    =/  paf  (~(get by res) nam)
    ?~  paf  ~
    =/  dat  (on-peek:pof [%x u.paf])
    ?:  ?|  ?=(~ dat)
            ?=(~ u.dat)
        ==
      ~&  >>>  [%mast dap.bowl %scry-failed `path`[%x u.paf]]
      ~
    ?:  =(p.u.u.dat mak)
      :-  ~
      :+  nam
          u.paf
          q.u.u.dat
    =/  tub  .^(tube:clay %cc (bem /[p.u.u.dat]/[mak]))
    :-  ~
    :+  nam
        u.paf
        (tub q.u.u.dat)
  ::
  ++  spoof-bowl
    %_  bowl
      src  src
      sap  /gall/[dap.bowl]
    ==
  :: :: :: :: :: :: ::
  ::
  --
::
--

