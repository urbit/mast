/-  *mast
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
++  parse-channel-data
  |=  jon=json
  ^-  [rode rope crow]
  =,  dejs:format
  =+  ^-  [rod=rode sub=path eve=path dat=(map @t @t)]
      %.  jon
      %-  ot
      :~  com+so  :: expexts the component's key,
          sub+pa  :: and the sub path from the client
          path+pa
          data+(om so)
      ==
  =/  [src=ship rop=rope]  (parse-client-sub-path sub)
  :+  rod  rop
  :-  eve  dat
::
++  make-client-sub-path
  |=  [src=ship rop=rope]
  ^-  path
  /mast/ui/[(scot %p src)]/[(scot %uv (jam rop))]
::
++  parse-client-sub-path
  |=  paf=path
  ^-  [ship rope]
  ?>  ?=([%mast %ui @ta @ta ~] paf)
  :-  (slav %p i.t.t.paf)
  ;;  rope
      (cue (slav %uv i.t.t.t.paf))
::
++  make-direct-http-cards
  |=  [rid=@ta hed=response-header.simple-payload:http dat=(unit octs)]
  ^-  (list card)
  :~  [%give %fact ~[/http-response/[rid]] [%http-response-header !>(hed)]]
      [%give %fact ~[/http-response/[rid]] [%http-response-data !>(dat)]]
      [%give %kick ~[/http-response/[rid]] ~]
  ==
::
++  make-diff-card
  |=  [src=ship rop=rope jon=json]
  ^-  card
  :*  %give  %fact  [(make-client-sub-path src rop) ~]
      %json  !>(jon)
  ==
::
++  make-com-subscription-card
  |=  act=?(%add %del)
  ^-  card
  =/  des  q.byk.bowl
  :*  %pass  /mast/deck/[des]  %arvo  %c  %warp  our.bowl  des
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
++  handle-component-buoys
  |=  [src=ship rop=rope bos=(list buoy)]
  ^+  cor
  ?~  bos  cor
  ?-  -.i.bos
    ::
      %add
    =/  sus  (~(get by navy) q.i.bos)
    ?^  sus
      =/  bub  (~(get by u.sus) [src rop])
      %=  $
        bos  t.bos
        navy
          %+  ~(put by navy)  q.i.bos
          ?~  bub
            %+  ~(put by u.sus)  [src rop]  (silt p.i.bos ~)
          %+  ~(put by u.sus)  [src rop]  (~(put in u.bub) p.i.bos)
      ==
    =.  cor  (emit (make-resource-subscription-card [%add q.i.bos]))
    %=  $
      bos  t.bos
      navy  (~(put by navy) q.i.bos (malt [[src rop] (silt p.i.bos ~)] ~))
    ==
    ::
      %del
    =/  sus  (~(get by navy) q.i.bos)
    ?~  sus
      %=  $
        bos  t.bos
      ==
    =.  u.sus
      =/  bub  (~(get by u.sus) [src rop])
      ?~  bub  u.sus
      =.  u.bub  (~(del in u.bub) p.i.bos)
      ?^  u.bub  (~(put by u.sus) [src rop] u.bub)
      %-  ~(del by u.sus)  [src rop]
    ?^  u.sus
      %=  $
        bos  t.bos
        navy  (~(put by navy) q.i.bos u.sus)
      ==
    =.  cor  (emit (make-resource-subscription-card [%del q.i.bos]))
    %=  $
      bos  t.bos
      navy  (~(del by navy) q.i.bos)
    ==
    ::
  ==
::
++  make-component-buoys
  |=  [act=?(%add %del) rod=rode bom=boom pol=pool]
  ^-  (list buoy)
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
          [%clean kil=(list [src=ship rop=rope])]
          [%all ~]
      ==
  =/  guf=(list [key=[src=ship rop=rope] val=isle])  ~(tap by gulf)
  |-  ^+  cor
  ?~  guf  cor
  ?.  ?|  ?=(%all -.act)
          &(?=(%bound -.act) =(bas.act bas.rop.key.i.guf))
          &(?=(%clean -.act) ?=(^ (find ~[key.i.guf] kil.act)))
      ==
    %=  $
      guf  t.guf
    ==
  =/  cos=(list [rod=rode cov=cove])  ~(tap by val.i.guf)
  |-  ^+  cor
  ?~  cos
    %=  ^$
      guf  t.guf
    ==
  =.  cor
    %^  handle-component-buoys  src.key.i.guf  rop.key.i.guf
    %:  make-component-buoys  %del  rod.i.cos  bom.cov.i.cos  res.lin.cov.i.cos
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
  =^  caz  you  (~(on-watch you bowl) poe)
  %-  emil  caz
::
++  leave
  |=  poe=(pole @ta)
  ^+  cor
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
      =/  liv
        %+  roll  ~(val by sup.bowl)
        |=  [[who=ship paf=path] acc=(set [ship rope])]
        ::  /mast/ui/[ship]/[rope]
        ?.  ?=([%mast %ui *] paf)  acc
        =/  [src=ship rop=rope]  (parse-client-sub-path paf)
        %-  ~(put in acc)  [who rop]
      =/  kil
        %-  ~(dif in ~(key by gulf))  liv
      %-  del-component-state  [%clean ~(tap in kil)]
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
      %mast-bind
    =/  bid  !<  bind  vase
    ?:  (~(has by dock) p.bid)
      ~&  >>>  "%mast-bind failed: /{(trip p.bid)} already exists"
      !!
    =.  dock  (~(put by dock) bid)
    ~&  >  "%mast-bind: /{(trip p.bid)} --> {(trip com.q.bid)}"
    %-  emit  (bind-eyre-url /[p.bid])
    ::
      %mast-unbind
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
      =/  ui-core  (ui-abed:ui src.bowl u.rup)
      =^  [sal=manx bos=(set buoy)]  ui-core  ui-moor:ui-core
      =.  gulf  ui-abet:ui-core
      =.  cor  (handle-component-buoys src.bowl u.rup ~(tap in bos))
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
    =/  [rod=rode rop=rope cro=crow]  (parse-channel-data i.t.p.jon)
    =^  caz  you  (ui-sway:(ui-abed:ui src.bowl rop) rod cro)
    %-  emil  caz
    ::
  ==
::
++  agent
  |=  [wir=(pole @ta) sin=sign:agent:gall]
  ^+  cor
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
        ^-  (list [[src=ship rop=rope] dat=(set rode)])
        %~  tap  by  u.sus
      |-  ^+  cor
      ?~  gus  cor
      =/  cus  ~(tap in dat.i.gus)
      |-  ^+  cor
      ?~  cus  ^$(gus t.gus)
      =/  ui-core  (ui-abed:ui src.i.gus rop.i.gus)
      =^  [jon=json bos=(set buoy)]  ui-core  (ui-furl:ui-core i.cus)
      =.  gulf  ui-abet:ui-core
      =?  cor  .?(bos)  (handle-component-buoys src.i.gus rop.i.gus ~(tap in bos))
      =?  cor  .?(jon)  (emit (make-diff-card src.i.gus rop.i.gus jon))
      %=  $
        cus  t.cus
      ==
      ::
    ==
    ::
  ==
::
++  ui
  |_  [src=ship rop=rope yel=isle]
  ++  ui-core  .
  ++  ui-abet  (~(put by gulf) [src rop] yel)
  ++  ui-abed
    |=  [s=ship r=rope]
    ^+  ui-core
    =/  yul  (~(get by gulf) [s r])
    %_  ui-core
      src  s
      rop  r
      yel  ?^(yul u.yul ~)
    ==
  ::
  :: ++ui-moor
  :: render from the root
  ++  ui-moor
    ^-  [[manx (set buoy)] _ui-core]
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
    :_  bos.wak
    %_  doc
      a.g
        :~  [%our +:(scow %p our.bowl)]
            [%app (trip dap.bowl)]
            [%sub (spud (make-client-sub-path src rop))]
        ==
      c.i.c  [script-element c.i.c.doc]
      i.t.c  sal
    ==
  ::
  :: ++ui-furl
  :: rerender and diff a component
  ++  ui-furl
    |=  rod=rode
    ^-  [[json (set buoy)] _ui-core]
    =/  cov  (~(got by yel) rod)
    =/  com  (~(got by deck) com.lin.cov)
    =/  cun  +(dif.cov)
    =/  new  (process-sail rod cun ~(sail com (make-hull boom.com lin.cov)))
    =/  dif  (luff [aft.cov ~] [new ~])
    ?~  q.dif
      :-  ~^~  ui-core
    :: if there is a diff, build the full diff object
    :: with the key and diff counter for this component
    =/  jon
      ^-  json
      :-  %o
      %-  my
      :~  ['p' [%s rod]]
          ['q' [%n (crip ((d-co:co 1) cun))]]
          ['r' [%a q.dif]]
      ==
    =.  yel
      %.  add.p.dif
      %~  uni  by
      %+  ~(put by yel)  rod
      %_  cov
        aft  new
        dif  cun
      ==
    =^  bos=(set buoy)  yel
      =/  bos  *(set buoy)
      =/  ros  ~(tap in del.p.dif)
      |-  ^-  [(set buoy) isle]
      ?~  ros  [bos yel]
      =/  cuv  (~(get by yel) i.ros)
      ?~  cuv  $(ros t.ros)
      %=  $
        ros  t.ros
        bos  (~(gas in bos) (make-component-buoys %del i.ros bom.u.cuv res.lin.u.cuv))
        yel  (~(del by yel) i.ros)
      ==
    :_  ui-core
    :-  jon  (~(uni in bos.p.dif) bos)
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
        :-  (~(gas in bos.q) (make-component-buoys %add rod bom.cov res.lin))
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
    :-  (~(uni in bos.a) bos.b)
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
    :-  (~(uni in bos.a) bos.b)
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
          %-  swig
          :*  %delete
              [%a (turn old |=(m=manx [%s (getv %key a.g.m)]))]
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
          %-  swig
          :*  %move
              [%s (getv %key a.g.i.new)]
              [%n (getv %i a.g.i.new)]
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
            bos.p  (~(uni in bos.p.acc) bos.wak)
            add.p  (~(uni by add.p.acc) new.wak)
            q
              %+  snoc  q.acc
              %-  swig
              :*  %new
                  [%s pkey]
                  [%n (crip ((d-co:co 1) i))]
                  [%s (crip (en-xml:html i.new))]
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
                  %-  swig
                  :*  %change-attr
                      [%s k.nnky]
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
                  %-  swig
                  :*  %move
                      [%s k.nkey]
                      [%n (crip ((d-co:co 1) i))]
                  ==
                ?:  &(?=(~ del.jib) ?=(~ new.jib))  q.acc
                :_  q.acc
                %-  swig
                :*  %change-attr
                    [%s k.nkey]
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
            %-  swig
            :*  %text
                [%s (getv %key a.g.i.new)]
                [%s txt]
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
              %-  swig
              :*  %change-attr
                  [%s k.nkey]
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
        $:  [%a del=(list [%s @t])]
            [%a new=(list [%a [%s @t] [%s @t] ~])]
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
        [%s `@t`?>(?=(@ n) n)]
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
          :-  %a
          :~  [%s `@t`?>(?=(@ n.i.nm) n.i.nm)]
              [%s (crip v.i.nm)]
          ==
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
          :-  %a
          :~  [%s `@t`?>(?=(@ n.i.nm) n.i.nm)]
              [%s (crip v.i.nm)]
          ==
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
  :: ++swig
  :: takes +$jiff which is the json diff format for the client,
  :: and turns it into the full json object to be sent.
  ++  swig
    |=  jif=jiff
    ^-  json
    :-  %o
    %-  my
    ?-  -.jif
      %new
        :~  ['p' [%s 'n']]
            ['q' parent-key.jif]
            ['r' index.jif]
            ['s' data.jif]
        ==
      %delete
        :~  ['p' [%s 'd']]
            ['q' keys.jif]
        ==
      %move
        :~  ['p' [%s 'm']]
            ['q' key.jif]
            ['r' index.jif]
        ==
      %change-attr
        :~  ['p' [%s 'c']]
            ['q' key.jif]
            ['r' del.jif]
            ['s' new.jif]
        ==
      %text
        :~  ['p' [%s 't']]
            ['q' container-key.jif]
            ['r' data.jif]
        ==
    ==
  ::
  --
::
--

