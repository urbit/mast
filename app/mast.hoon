/-  *mast
/*  mast-js  %js  /lib/mast/js
::
:: O╭ ┌┬╮╭─╮╭─╮┌┬┐
:: ╭╯ │││├─┤╰─╮ │
:: ╯O ┴ ┴┴ ┴╰─╯ ┴
::
|%
+$  state-0
  $:  =dock
      =lake
  ==
+$  state-n
  $%  [%state-0 state-0]
  ==
+$  card  card:agent:gall
--
::
=|  $>  %state-0  state-n
=*  state  -
=<
^-  agent:gall
|_  =bowl:gall
+*  this  .
    cor  ~(. +> [bowl ~])
::
++  on-init
  ^-  (quip card _this)
  :_  this
  :~  (bind-url dap.bowl /mast)
  ==
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
++  on-watch  |=(path ^-((quip card _this) `this))
++  on-leave  |=(path ^-((quip card _this) !!))
++  on-peek   |=(path ^-((unit (unit cage)) !!))
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
++  on-fail   |=([term tang] ^-((quip card _this) !!))
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
++  script-node
  ^-  manx
  ;script: {(trip mast-js)}
::
++  bind-url
  |=  [app=@tas url=path]
  ^-  card:agent:gall
  :*  %pass  /bind  %arvo  %e  %connect  [~ url]  app
  ==
::
++  make-component-path
  |=  [bas=knot rop=rope]
  ^-  path
  /[bas]/[?~(q.rop %$ (scot %p u.q.rop))]/[(scot %uv p.rop)]
::
++  parse-component-path
  |=  pax=path
  ^-  [knot rope]
  ?>  ?=([@ta @ta @ta ~] pax)
  :-  i.pax
  :-  (slav %uv i.t.t.pax)
  ?:  =(%$ i.t.pax)  ~
  :-  ~  (slav %p i.t.pax)
::
++  make-component-wire
  |=  [bas=knot boy=buoy]
  ^-  wire
  %+  weld
      (make-component-path bas p.boy)
      q.boy
::
++  parse-component-wire
  |=  wyr=wire
  ^-  [knot rope path]
  ?>  ?=([@ @ @ *] wyr)
  =/  (pair knot rope)  (parse-component-path wyr(t.t.t ~))
  :+  p
      q
      t.t.t.wyr
::
++  parse-channel-data
  |=  jon=json
  ^-  [knot rope crow]
  =,  dejs:format
  =+  ^-  [com=path eve=path dat=(map @t @t)]
      %.  jon
      %-  ot
      :~  com+pa
          path+pa
          data+(om so)
      ==
  =/  [bas=knot rop=rope]  (parse-component-path com)
  :+  bas  rop
  :-  eve  dat
::
++  make-diff-cards
  |=  [bas=knot rop=rope pax=(list path) jon=(list json)]
  ^-  (list card)
  ?.  .?  jon  ~
  :_  ~
  :*  %give  %fact  pax  %json  !>(`json`[%a jon])
  ==
::
:: ++make-resource-subscription-cards
:: the %mast agent subscribes to an on-watch path
:: in the agent specified in the first path segment.
++  make-resource-subscription-cards
  |=  [bas=knot bos=(set buoy)]
  ^-  (list card)
  %+  roll  ~(tap in bos)
  |=  [b=buoy a=(list card)]
  ?<  ?=(~ q.b)
  =/  age  i.q.b
  =/  for  t.q.b
  :_  a
  ?-  -.b
    %add  [%pass (make-component-wire bas b) %agent [our.bowl age] %watch [%r for]]
    %del  [%pass (make-component-wire bas b) %agent [our.bowl age] %leave ~]
  ==
::
++  make-component-buoys
  |=  [act=?(%add %del) rop=rope bom=boom tid=tide]
  ^-  (list buoy)
  %+  murn  bom
  |=  [nam=@tas mak=@tas]
  =/  paf  (~(get by tid) nam)
  ?~  paf  ~
  :^  ~  act  rop  u.paf
::
++  make-direct-http-cards
  |=  [rid=@ta hed=response-header.simple-payload:http dat=(unit octs)]
  ^-  (list card:agent:gall)
  :~  [%give %fact ~[/http-response/[rid]] [%http-response-header !>(hed)]]
      [%give %fact ~[/http-response/[rid]] [%http-response-data !>(dat)]]
      [%give %kick ~[/http-response/[rid]] ~]
  ==
::
++  make-404-res
  |=  rid=@ta
  ^-  (list card:agent:gall)
  %^  make-direct-http-cards  rid  [404 ['Content-Type' 'text/html'] ~]
  :-  ~
  %-  as-octt:mimes:html
  %-  en-xml:html
  ;html
    ;head;
    ;body
      ;h1: 404
    ==
  ==
::
++  make-gull-cards
  |=  [src=ship hok=hook blo=blow]
  ^-  (list card:agent:gall)
  %+  murn  blo
  |=  [for=@tas dat=cage]
  ?:  =(for dap.bowl)  ~
  :-  ~
  :*  %pass  /blow-poke  %agent  [our.bowl for]  %poke
      %mast-poke  !>(`gull`[src hok dat])
  ==
::
++  make-com-subscription-card
  |=  [act=?(%add %del) des=desk]
  ^-  card
  :*  %pass  /lake/[des]  %arvo  %c
      %warp  our.bowl  des
      ?-  act
        %add  [~ %next %z da+now.bowl /com]
        %del  ~
      ==
  ==
::
++  dock-has-desk
  |=  des=desk
  ^-  ?
  %-  ~(any by dock)
  |=  [p=hook *]
  .=  desk.p  des
::
++  put-lake
  |=  des=desk
  =/  fis  .^((list path) %ct (bam des /com))
  |-  ^-  ^lake
  ?~  fis  lake
  ~&  (bam des i.fis)
  =/  fil  .^(vase %ca (bam des i.fis))
  =/  huk  `hook`[des (rear (snip i.fis))]
  =/  mat  (mole |.(!<(mast fil)))
  ?^  mat
    %=  $
      fis  t.fis
      lake  (~(put by lake) huk [%mast u.mat])
    ==
  =/  mit  (mole |.(!<(mist fil)))
  ?^  mit
    %=  $
      fis  t.fis
      lake  (~(put by lake) huk [%mist u.mit])
    ==
  %=  $
    fis  t.fis
  ==
::
++  del-lake
  |=  des=desk
  ^-  ^lake
  %-  malt
  %+  skip  ~(tap by lake)
  |=  [k=hook *]
  .=  des  desk.k
::
++  del-bound-component-state
  |=  bas=knot
  ^+  cor
  =/  duk  (~(get by dock) bas)
  ?~  duk  cor
  =/  bos
    ^-  (set buoy)
    %-  ~(rep by q.u.duk)
    |=  [[k=rope v=bitt] a=(set buoy)]
    %-  ~(gas in a)  (make-component-buoys %del k bom.v res.v)
  =.  dock  (~(del by dock) bas)
  %-  emil
  %+  make-resource-subscription-cards  bas  bos
::
++  del-all-component-state
  ^+  cor
  =^  caz  dock
    %+  ~(rib by dock)  *(list card)
    |=  [[k=knot v=(pair hook deck)] a=(list card)]
    :_  [k p.v ~]
    %+  weld  a
    %+  make-resource-subscription-cards  k
    %-  ~(rep by q.v)
    |=  [[k=rope v=bitt] b=(set buoy)]
    %-  ~(gas in b)  (make-component-buoys %del k bom.v res.v)
  %-  emil  caz
::
++  save
  ^-  vase
  !>  state(lake ~)
::
++  load
  |=  =vase
  ^+  cor
  =/  lod  !<  state-n  vase
  ?-  -.lod
    ::
      %state-0
    =.  state  lod
    :: cleanup previous component state
    =.  cor  del-all-component-state
    :: get component cores
    =/  des
      ^-  (list desk)
      %~  tap  in
      ^-  (set desk)
      %-  ~(rep by dock)
      |=  [[k=knot v=(pair hook deck)] a=(set desk)]
      %-  ~(put in a)  desk.p.v
    |-  ^+  cor
    ?~  des  cor
    =.  lake  (put-lake i.des)
    =.  cor  (emit (make-com-subscription-card %add i.des))
    %=  $
      des  t.des
    ==
    ::
  ==
::
++  poke
  |=  [=mark =vase]
  ^+  cor
  ?+  mark  ~|(bad-poke/mark !!) 
    ::
      %mast-bind
    =/  bid  !<  bind  vase
    ?:  (~(has by dock) knot.bid)
      ~&  >>>  "%mast-bind failed: /{(trip knot.bid)} already exists"
      !!
    =?  cor  !(dock-has-desk desk.bid)
      =.  lake  (put-lake desk.bid)
      %-  emit  (make-com-subscription-card %add desk.bid)
    =.  dock  (~(put by dock) knot.bid [[desk.bid name.bid] ~])
    =/  rut  (~(get by lake) [desk.bid name.bid])
    ?~  rut
      ~&  >>>  "%mast-bind failed: {<name.bid>} not found"
      !!
    ?.  ?=(%mist -.u.rut)
      ~&  >>>  "%mast-bind failed: {<name.bid>} is not a router gate"
      !!
    ~&  >  "%mast-bind: /{(trip knot.bid)} --> {<desk.bid>} /com {<name.bid>}"
    cor
    ::
      %mast-unbind
    =/  not  !<  knot  vase
    =/  duk  (~(get by dock) not)
    ?~  duk
      ~&  >>  "%mast-unbind: /{(trip not)} is already unbound"
      !!
    =.  cor  (del-bound-component-state not)
    =?  cor  !(dock-has-desk desk.p.u.duk)
      =.  lake  (del-lake desk.p.u.duk)
      %-  emit  (make-com-subscription-card %del desk.p.u.duk)
    ~&  >  "%mast-unbind: /{(trip not)} unbound"
    cor
    ::
      %handle-http-request
    =+  !<  [rid=@ta req=inbound-request:eyre]  vase
    ?+  method.request.req  ~|(bad-method/method.request.req !!)
      ::
        %'GET'
      =/  url  (stab url.request.req)                               :: TODO: better url parsing
      =.  url  ?>  ?=([%mast *] url)  t.url  :: temporary: assumes /mast prefix
      ?~  url
        %-  emil
        %-  make-404-res  rid
      =/  kel  `keel`[our.bowl i.url t.url ~]  :: TODO: query params instead of null
      =/  doc  (~(get by dock) bas.kel)
      ?~  doc
        %-  emil
        %-  make-404-res  rid
      =/  ui-core  (ui-abed:ui bas.kel u.doc)
      =^  sal=manx  ui-core  (ui-moor:ui-core [~ src.bowl] kel)
      =^  bos=(set buoy)  dock  ui-abet:ui-core
      %-  emil
      %+  weld  (make-resource-subscription-cards bas.kel bos)
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
      cor
    =/  [bas=knot rop=rope cro=crow]  (parse-channel-data i.t.p.jon)
    =/  doc  (~(get by dock) bas)
    ?~  doc  ~&(>>> %missing-binding-on-event !!)
    =/  [com=hook blo=blow]  (ui-sway:(ui-abed:ui bas u.doc) rop cro)
    %-  emil  (make-gull-cards src.bowl com blo)
    ::
  ==
::
++  agent
  |=  [=wire =sign:agent:gall]
  ^+  cor
  ?+  -.sign  cor
    ::
      %fact
    =/  [bas=knot rop=rope res=path]  (parse-component-wire wire)
    =/  doc  (~(get by dock) bas)
    ?~  doc  ~&(>>> %missing-binding-on-update !!)
    =/  ui-core  (ui-abed:ui bas u.doc)
    =^  [pax=(list path) jon=(list json)]  ui-core  (ui-furl:ui-core rop)
    =^  bos=(set buoy)  dock  ui-abet:ui-core
    %-  emil
    %+  weld  (make-diff-cards bas rop pax jon)
    %+  make-resource-subscription-cards  bas  bos
    ::
      %kick
    =/  [bas=knot rop=rope res=path]  (parse-component-wire wire)
    %-  emil
    %+  make-resource-subscription-cards  bas  [[%add rop res] ~ ~]
    ::
  ==
::
++  arvo
  |=  [=wire sign=sign-arvo]
  ^+  cor
  ?+  sign  cor
    ::
      [%clay %writ *]
    ?.  ?=([%lake @ta ~] wire)  cor
    :: on change to a desk's /com
    :: delete all component state   TODO: only delete affected component state
    =.  cor  del-all-component-state
    :: and reload components
    =.  lake  (del-lake i.t.wire)
    =.  lake  (put-lake i.t.wire)
    %-  emit  (make-com-subscription-card %add i.t.wire)
    ::
  ==
::
++  ui
  =|  [bos=(set buoy) bas=knot rut=hook dek=deck]
  |%
  ++  ui-core  .
  ++  ui-abet  :-  bos  (~(put by dock) bas rut dek)
  ++  ui-abed  |=  [b=knot r=hook d=deck]  ui-core(bas b, rut r, dek d)
  ::
  :: ++ui-moor
  :: slam the router gate, producing the full manx for that route
  ++  ui-moor
    |=  [src=navy kel=keel]
    ^-  [manx _ui-core]
    =/  doc
      %.  kel
      ^-  mist
      =>  (~(got by lake) rut)
      ?>  ?=(%mist -)  +
    :: temporary: assert the structure of the document
    :: produced from the router
    ?.  ?&  ?=([* * ~] c.doc)
            ?=(%html n.g.doc)
            ?=(%head n.g.i.c.doc)
            ?=(%body n.g.i.t.c.doc)
            ?=([[[[%mast @] *] *] ~] c.i.t.c.doc)
        ==
      ~&  >>>  [%malformed-document-from-router rut]
      !!
    =/  [rod=rode lin=line]  (parse-component-element i.c.i.t.c.doc)
    =/  [sal=manx wak=wake]  (build-component-branch src [`@uv`bas ~] rod lin)
    :_  %_  ui-core
          bos  (~(uni in bos) bos.wak)
          dek  (~(uni by dek) dek.wak)
        ==
    =-  -(a.g `mart`[[%our +:(scow %p our.bowl)] [%src +:(scow %p src.bowl)] ~])
    ^-  manx  doc(c.i.c [script-node c.i.c.doc], i.c.i.t.c sal)
  ::
  :: ++ui-sway
  :: handle an event from the client
  ++  ui-sway
    |=  [rop=rope cro=crow]
    ^-  [hook blow]
    =/  duk  (~(get by dek) rop)
    ?~  duk  ~&(>>> %missing-component-on-event !!)
    =/  com  ^-  mast  =>((~(got by lake) com.u.duk) ?>(?=(%mast -) +))
    =/  hul
      ^-  hull
      :*  our.bowl
          src.u.duk
          now.bowl
          par.u.duk
          (hydrate-component bom.u.duk res.u.duk)
      ==
    :-  com.u.duk
    %-  ~(spar com hul)  cro
  ::
  :: ++ui-furl
  :: handle a resource update for a component
  ++  ui-furl
    |=  rop=rope
    ^-  [[(list path) (list json)] _ui-core]
    =/  duk  (~(get by dek) rop)
    ?~  duk  ~&(>>> %missing-component-on-update !!)
    =/  com  ^-  mast  =>((~(got by lake) com.u.duk) ?>(?=(%mast -) +))
    =/  [pol=pool sal=manx]
      %+  process-sail  rop
      %~  sail  com
      :*  our.bowl
          src.u.duk
          now.bowl
          par.u.duk
          (hydrate-component bom.u.duk res.u.duk)
      ==
    =/  dif  (luff src.u.duk rop [aft.u.duk ~] [sal ~])
    =^  boz=(set buoy)  dek  (handle-component-dels rop u.duk ~(tap in del.p.dif))
    =:  bos  (~(uni by bos) (~(uni by boz) bos.p.dif))
        dek  (~(uni by dek) add.p.dif)
      ==
    =.  dek  (~(put by dek) rop u.duk(aft sal))
    =;  pax
      :-  [pax q.dif]  ui-core
    :: build fact paths
    =;  cos
      :: match root component paths with existing subscriptions in sup
      ^-  (list path)
      =<  q
      %+  roll  ~(val by sup.bowl)
      |=  [[who=ship paf=path] acc=[p=(set ship) q=(list path)]]
      ::  the first segment is the client's patp; check only the component path
      ?.  ?&  ?=(^ paf)
              (~(has in cos) t.paf)
              !(~(has in p.acc) who)
          ==
        acc
      %_  acc
        p  (~(put in p.acc) who)
        q  [paf q.acc]
      ==
    :: get all paths for root components in which the update occurs
    =|  acc=(set path)
    |-  ^+  acc
    =/  bit  (~(get by dek) rop)
    ?~  bit  acc
    =/  pas  ~(tap in pas.u.bit)
    |-  ^+  acc
    ?~  pas  acc
    :: the base segment is in the parent set if it is a root
    ?:  =(p.i.pas bas)
      %=  $
        pas  t.pas
        acc  (~(put in acc) (make-component-path bas rop))
      ==
    %=  $
      pas  t.pas
      acc  ^$(rop i.pas)
    ==
  ::
  :: ++parse-component-element
  :: extract component data from a component element;
  :: the format for a component element is defined in
  :: the ++make arm in /sur/mast/hoon
  ++  parse-component-element
    |=  sal=manx
    ^-  [rode line]
    ?>  ?=([%mast @] n.g.sal)
    =|  lin=line
    =:  -.lin  `hook`=>(=>((stab +.n.g.sal) ?>(?=([@ @ ~] .) [- +<])) ?<(?=(~ .) .))
        +.lin
          %+  roll  a.g.sal
          |=  [[n=mane v=tape] a=[par=gust res=tide]]
          ?+  n  a
            [%gust @]  a(par (~(put by par.a) +.n (crip v)))
            [%gale @]  a(res (~(put by res.a) +.n (scan v stap)))
          ==
      ==
    :-  (mug lin)  lin  :: TEST: (jam lin)  lin
  ::
  :: ++process-sail
  :: process a component's rendered sail,
  :: adds keys and gathers any component element data
  ++  process-sail
    |=  [rop=rope sal=manx]
    =/  n  0
    :: set prev-key using the atom portion of the component key of this sail
    =/  prev-key  p.rop
    =/  pos-key  *(list @)
    :: add a mast attribute with this component's identifying path
    =.  a.g.sal
      :_  a.g.sal
      :-  %mast  (spud (make-component-path bas rop))
    |-  ^-  [pool manx]
    :: temporary: if text node, add text node wrapper
    =?  sal  =(%$ n.g.sal)  ;t-  ;+  sal  ==
    :: handle component elements separately
    ?:  ?=([%mast @] n.g.sal)
      =/  [key=rode lin=line]  (parse-component-element sal)
      :-  [[key lin] ~ ~]
      %_  sal
        a.g  [[%key ((w-co:co 1) key)] a.g.sal]
      ==
    :: also handle client-state elements separately
    ?:  ?=([%client %state] n.g.sal)
      =/  key  `@uw`(mug a.g.sal)
      :-  ~
      %_  sal
        a.g  [[%key ((w-co:co 1) key)] a.g.sal]
      ==
    :: else, if not a component element,
    :: build the current element's key:
    =/  found-key
      ^-  tape
      %+  roll  a.g.sal
      |=  [[n=mane v=tape] a=tape]
      ?:  =(%key n)  v  a
    =/  this-key
      ^-  rode
      ?:  =(0 n)  p.rop
      %-  mug  [prev-key pos-key found-key]
    =.  a.g.sal
      :-  [%key ((w-co:co 1) this-key)]
      ?~  found-key  a.g.sal
      %+  skip  a.g.sal
      |=  [n=mane v=tape]  =(%key n)
    :: don't recurse for these elements:
    ?:  ?|  =(%t- n.g.sal)
            =(%input n.g.sal)   =(%textarea n.g.sal)
            =(%script n.g.sal)  =(%img n.g.sal)
            =(%link n.g.sal)    =(%hr n.g.sal)
            =(%meta n.g.sal)    =(%base n.g.sal)
        ==
      :-  ~  sal
    :: process child elements, giving them the next key state
    =^  pol  c.sal
      =:  prev-key  ?^  found-key  this-key  prev-key
          pos-key  ?^  found-key  ~  pos-key
        ==
      =<  [+.q p]
      %^  spin  c.sal  *[@ pool]
      |=  [m=manx i=@ a=pool]
      =^  b  m  ^$(n +(n), sal m, pos-key [i pos-key])
      :-  m
      :-  +(i)
      %-  ~(uni by a)  b
    :-  pol  sal
  ::
  ++  hydrate-component
    |=  [bom=boom tid=tide]
    ^-  gale
    %-  malt
    %+  murn  bom
    |=  [nam=@tas mak=@tas]
    ^-  (unit [term path vase])
    =/  paf  (~(get by tid) nam)
    ?~  paf  ~
    ?~  u.paf  ~&(>>> %null-path ~)
    ?:  =(%$ mak)
      :-  ~  [nam u.paf !>(~)]
    :: the path is prefixed with an agent name
    =/  age  i.u.paf
    =/  for  (bam age t.u.paf)
    =/  des  .^(desk %gd (bam age /$))
    =/  fil  .^(cage %gr for)
    ?:  =(p.fil mak)
      :-  ~  [nam u.paf q.fil]
    =/  tub  .^(tube:clay %cc (bam des /[p.fil]/[mak]))
    :-  ~  [nam u.paf (tub q.fil)]
  ::
  :: ++build-component-branch
  :: build out a full branch starting from some component,
  :: rendering any new component that does not yet exist in the deck
  ++  build-component-branch
    |=  [src=navy pre=rope rod=rode lin=line]
    ^-  [manx wake]
    =/  com  ^-  mast  =>((~(got by lake) com.lin) ?>(?=(%mast -) +))
    =/  who  ^-  navy  ?:(?=(%auth mode.com) src ~)
    =/  [new=? bit=bitt]
      =/  but  (~(get by dek) [rod who])
      ?^  but  [| u.but]
      =/  [pol=pool sal=manx]
        %+  process-sail  [rod who]
        %~  sail  com
        :*  our.bowl
            who
            now.bowl
            par.lin
            (hydrate-component boom.com res.lin)
        ==
      :-  &
      ^-  bitt
      :*  mode.com
          boom.com
          who
          [pre ~ ~]
          sal
          lin
      ==
    =/  mal  `marl`[aft.bit ~]
    =-  ?>  ?=(^ p)
        :-  i.p
        ?.  new  q
        :-  (~(gas in bos.q) (make-component-buoys %add [rod who] boom.com res.lin))
            (~(put by dek.q) [rod who] bit)
    |-  ^-  (pair marl wake)
    %^  spin  mal  *wake
    |=  [m=manx a=wake]
    =^  b=wake  m
      ?.  ?=([%mast @] n.g.m)
        =+  ^$(mal c.m)
        :-  q
            m(c p)
      =/  [r=rode l=line]  (parse-component-element m)
      =<  [q p]
      ^-  (pair manx wake)
      %=  ^^$
        pre  [rod who]
        rod  r
        lin  l
      ==
    :-  m
    :-  (~(uni in bos.a) bos.b)
        (~(uni by dek.a) dek.b)
  ::
  ++  handle-component-dels
    |=  [rop=rope bit=bitt del=(list (pair rode hook))]
    =|  boz=(set buoy)
    |-  ^-  [_boz deck]
    ?~  del  [boz dek]
    =/  cod  ^-  mast  =>((~(got by lake) q.i.del) ?>(?=(%mast -) +))
    ?:  &(!?=(%auth mod.bit) ?=(%auth mode.cod))
      :: if the parent is not auth and the child is,
      :: go through all of dek and do the delete process for any with equal rode
      =^  boa=(set buoy)  dek
        %-  ~(rep by dek)
        |=  [[k=rope v=bitt] a=(pair (set buoy) deck)]
        ?.  =(p.k p.i.del)  a(q (~(put by q.a) k v))
        =.  pas.v  (~(del in pas.v) rop)
        ?~  pas.v  a(p (~(gas in p.a) (make-component-buoys %del k bom.v res.v)))
            a(q (~(put by q.a) k v))
      %=  $
        del  t.del
        boz  (~(uni in boz) boa)
      ==
    :: else only delete one
    =/  nop
      ^-  rope
      :: if the child component is the same mode as the parent,
      :: get using the rode and the parent src,
      :: else the parent is auth and the child in not auth,
      :: so get from dek using the rode and null
      ?:  =(mod.bit mode.cod)  [p.i.del src.bit]  [p.i.del ~]
    =/  duk  (~(get by dek) nop)
    ?~  duk  $(del t.del)
    =.  pas.u.duk  (~(del in pas.u.duk) rop)
    ?^  pas.u.duk
      %=  $
        del  t.del
        dek  (~(put by dek) nop u.duk)
      ==
    %=  $
      del  t.del
      dek  (~(del by dek) nop)
      boz  (~(gas in boz) (make-component-buoys %del nop bom.u.duk res.u.duk))
    ==
  ::
  ++  handle-diff-branch-add
    |=  [src=navy pre=rope sal=manx]
    ^-  [wake manx]
    =/  mal  `marl`[sal ~]
    =-  ?>  ?=(^ p)  [q i.p]
    |-  ^-  (pair marl wake)
    %^  spin  mal  *wake
    |=  [m=manx a=wake]
    =^  b=wake  m
      ?.  ?=([%mast @] n.g.m)
        =+  ^$(mal c.m)
        :-  q
            m(c p)
      =/  [r=rode l=line]  (parse-component-element m)
      =<  [q p]
      ^-  (pair manx wake)
      %:  build-component-branch  src  pre  r  l
      ==
    :-  m
    :-  (~(uni in bos.a) bos.b)
        (~(uni by dek.a) dek.b)
  ::
  :: ++luff
  :: diffs manx into a format that gets sent and applied to sync the client.
  ++  luff
    |=  [src=navy rop=rope old=marl new=marl]
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
          =>  .(old `marl`old)
          %-  ~(uni in del.p.acc)
          |-  ^-  (set [rode hook])
          %+  roll  old
          |=  [m=manx a=(set [rode hook])]
          ?.  ?=([%mast @] n.g.m)
            %-  ~(uni in a)  ^$(old c.m)
          =/  [rod=rode lin=line]  (parse-component-element m)
          %-  ~(put in a)  [rod com.lin]
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
          =^  wak  i.new  (handle-diff-branch-add src rop i.new)
          %_  acc
            bos.p  (~(uni in bos.p.acc) bos.wak)
            add.p  (~(uni by add.p.acc) dek.wak)
            q
              %+  snoc  q.acc
              %-  swig
              :*  %new
                  [%s pkey]
                  [%n (scot %ud i)]
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
                  %^  newm  new  n
                  ;move-(i (y-co:co (add n i)), key (trip k.nnky));
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
              old  (newm old j ;skip-;)
              new  t.new
              i    +(i)
              q.acc
                =.  q.acc
                  %+  snoc  q.acc
                  %-  swig
                  :*  %move
                      [%s k.nkey]
                      [%n (scot %ud i)]
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
    ?:  ?=([%mast @] nn)  acc
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
      ?:  =(v.i.com v.i.nm)
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
  ++  newm
    |=  [ml=marl i=@ud mx=manx]
    =|  j=@ud
    |-  ^-  marl
    ?~  ml
      ~
    :-  ?:  =(i j)
          mx
        i.ml
    $(ml t.ml, j +(j))
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

