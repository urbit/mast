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
  :_  this
  :~  (bind-url dap.bowl /mast)
  ==
::
++  on-save
  ^-  vase
  !>  ~
::
++  on-load
  |=  =vase
  ^-  (quip card _this)
  :-  ~  this
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
  :-  ~  this
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
  /[bas]/[?~(q.rop %$ (scot %p u.q.rop))]/[(scot %uw p.rop)]
::
++  parse-component-path
  |=  pax=path
  ^-  [knot rope]
  ?>  ?=([@ta @ta @ta ~] pax)
  :-  i.pax
  :-  (slav %uw i.t.t.pax)
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
:: ++  parse-channel-data
::   |=  jon=json
::   ^-  [rope crow]
::   =,  dejs:format
::   =/  pok
::     ^-  [route=rope =path data=(map @t @t)]
::     %.  jon
::     %-  ot
::     :~  route+(ar (ot ~[name+so path+pa]))
::         path+pa
::         data+(om so)
::     ==
::   :-  route.pok
::   :-  path.pok  data.pok
::
:: ++  make-diff-cards
::   |=  [yon=ship jon=(list json)]
::   ^-  (list card)
::   ?.  .?  jon  ~
::   :_  ~
::   :*  %give  %fact  [(make-sub-path yon) ~]  %json  !>(`json`[%a jon])
::   ==
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
  |=  [src=ship hok=hook pok=(list (pair @tas cage))]
  ^-  (list card:agent:gall)
  %+  murn  pok
  |=  [for=@tas dat=cage]
  ?:  =(for dap.bowl)  ~
  :-  ~
  :*  %pass  /blow-poke  %agent  [our.bowl for]  %poke
      %mast-poke  !>(`gull`[src hok dat])
  ==
::
++  keep-desk-coms
  |=  hok=hook
  ^-  ?
  %-  ~(any by dock)
  |=  [p=hook *]
  .=  desk.p  desk.hok
::
++  put-lake      :: TODO: %warp %mult to subscribe to desk /com
  |=  des=desk
  ^+  cor
  :: components go in /com
  =/  fis  .^((list path) %ct (bam des /com))
  %_    cor
      lake
    |-  ^-  ^lake
    ?~  fis  lake
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
  ==
::
++  del-lake      :: TODO: cancel %warp to desk /com
  |=  des=desk
  %_    cor
      lake
    %-  malt
    %+  skip  ~(tap by lake)
    |=  [k=hook *]
    .=  des  desk.k
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
      ~&  >>>  "%mast-bind failed: {(trip knot.bid)} already exists"
      !!
    =.  dock  (~(put by dock) knot.bid [[desk.bid name.bid] ~])
    =.  cor  (put-lake desk.bid)
    =/  rut  (~(get by lake) [desk.bid name.bid])
    ?~  rut
      ~&  >>>  "%mast-bind failed: {(trip name.bid)} not found"
      !!
    ?.  ?=(%mist -.u.rut)
      ~&  >>>  "%mast-bind failed: {(trip name.bid)} is not a router"
      !!
    ~&  >  "%mast-bind: {(trip knot.bid)} --> {(trip desk.bid)} {(trip name.bid)}"
    cor
    ::
      %mast-unbind
    =/  not  !<  knot  vase
    =/  duk  (~(get by dock) not)
    ?~  duk
      ~&  >>  "%mast-unbind: {(trip not)} is already unbound"
      !!
    =.  dock  (~(del by dock) not)                                  :: TODO: close resource subscriptions
    =.  cor
      ?:  (keep-desk-coms p.u.duk)  cor
      %-  del-lake  desk.p.u.duk
    ~&  >  "%mast-unbind: {(trip not)} unbound"
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
      =/  ui-core  (ui-abed:ui bas.kel src.bowl u.doc)
      =^  sal=manx  ui-core  (ui-moor:ui-core kel)
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
    :: =/  [rop=rope cro=crow]  (parse-channel-data i.t.p.jon)
    :: ?<  ?=(~ rop)

    :: =/  ui-core  (ui-moor:(ui-abed:ui src.bowl i.rop) rop)
    :: =^  [local-update=? cards=(list card)]  ui-core  (ui-sway:ui-core cro)
    :: ?.  local-update
    ::   %-  emil  cards
    :: =^  [bos=(list buoy) jon=(list json)]  cor  ui-gust:ui-core
    :: %-  emil
    :: %+  weld  (make-diff-cards src.bowl jon)  cards
    cor

    ::
  ==
::
++  agent
  |=  [=wire =sign:agent:gall]
  ^+  cor
  ?+  -.sign  cor
    ::
      %fact
    :: =/  [car=@tas yon=ship rop=rope]  (parse-component-wire wire)
    :: ?<  ?=(~ rop)
    :: =^  [bos=(list buoy) jon=(list json)]  cor
    ::   ui-gust:(ui-moor:(ui-abed:ui yon i.rop) rop)
    :: %-  emil
    :: %+  weld  (make-resource-subscription-cards bos)
    :: %+  make-diff-cards  yon  jon
    cor
    ::
  ==
::
++  ui
  =|  [bos=(set buoy) bas=knot src=ship hok=hook dek=deck]
  |%
  ++  ui-core  .
  ++  ui-abet  :-  bos  (~(put by dock) bas hok dek)
  ++  ui-abed
    |=  [b=knot s=ship h=hook d=deck]
    %_  ui-core
      bas  b
      src  s
      hok  h
      dek  d
    ==
  ::
  :: ++ui-moor
  :: slam the router gate, producing the full manx for that route
  ++  ui-moor
    |=  kel=keel
    ^-  [manx _ui-core]
    =/  doc
      %.  kel
      ^-  mist
      =>  (~(got by lake) hok)
      ?>  ?=(%mist -)  +
    =/  [rod=rode lin=line]  (parse-component-element com.doc)
    =/  [sal=manx wak=wake]  (build-component-branch [rod ~] rod lin)  :: fix pre key?
    :_  %_  ui-core
          bos  (~(uni in bos) bos.wak)
          dek  (~(uni by dek) dek.wak)
        ==
    =-  -(a.g [[%our +:(scow %p our.bowl)] ~])
    ^-  manx  doc(hed [script-node hed.doc], com sal)
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
    :-  (jam lin)  lin
  ::
  :: ++process-sail
  :: process a component's rendered sail,
  :: adds keys and gathers any component element data
  ++  process-sail
    |=  [rop=rope sal=manx]
    :: set prev-key using the hash portion of the component key of this sail
    =/  prev-key  p.rop
    =/  pos-key  *(list @)
    :: add a mast:component attribute with this component's identifying path
    =.  a.g.sal
      :_  a.g.sal
      :-  [%mast %component]  (spud (make-component-path bas rop))
    |-  ^-  [pool manx]
    :: temporary: if text node, add text node wrapper
    =?  sal  =(%$ n.g.sal)  ;t-  ;+  sal  ==
    :: handle component elements separately
    ?:  ?=([%mast @] n.g.sal)
      =/  [key=rode lin=line]  (parse-component-element sal)
      :-  [[key lin] ~ ~]
      :~  [n.g.sal [[%key ((w-co:co 1) key)] ~]]
      ==
    :: else, if not a component element,
    :: build the current element's key:
    =/  found-key
      ^-  tape
      %+  roll  a.g.sal
      |=  [[n=mane v=tape] a=tape]
      ?:  =(%key n)  v  a
    =/  this-key  `rode`(mug [prev-key pos-key found-key])
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
      =^  b  m  ^$(sal m, pos-key [i pos-key])
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
  ++  add-component-buoys
    |=  [rop=rope bom=boom tid=tide]
    ^-  (list buoy)
    %+  murn  bom
    |=  [nam=@tas mak=@tas]
    =/  paf  (~(get by tid) nam)
    ?~  paf  ~
    :^  ~  %add  rop  u.paf
  ::
  :: ++build-component-branch
  :: build out a full branch starting from some component,
  :: rendering any new component that does not yet exist in the deck
  ++  build-component-branch
    |=  [pre=rope rod=rode lin=line]
    ^-  [manx wake]
    =/  com  ^-  mast  =>((~(got by lake) com.lin) ?>(?=(%mast -) +))
    =/  who  ^-  navy  ?:(?=(%auth mode.com) [~ src] ~)
    =/  [new=? bit=bitt]
      =/  but  (~(get by dek) [rod who])
      ?^  but  [| u.but]
      =/  [pol=pool sal=manx]
        %+  process-sail  [rod who]
        %~  sail  com
        :*  our.bowl
            who
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
        :-  (~(gas in bos.q) (add-component-buoys [rod who] boom.com res.lin))
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
  :: ++  unsubscribe-branch
  ::   |=  [r=rope d=deck]
  ::   ^-  (list buoy)
  ::   :-  [%del yon.ses r]
  ::   %-  ~(rep by q.d)
  ::   |=  [[k=line v=deck] a=(list buoy)]
  ::   %+  weld  a
  ::   %=  ^$
  ::     r  (snoc r k)
  ::     d  v
  ::   ==
  ::
  :: ++update-branch
  :: takes a component and its rope
  :: and potentially updates and rerenders it,
  :: and recursively does this for any nested
  :: components.
  :: ++  update-branch
  ::   =|  n=@
  ::   |=  $:  rop=rope
  ::           pop=prop
  ::           dek=deck
  ::       ==
  ::   ^-  [[(list buoy) (list json)] deck]
  ::   ?:  ?&  !=(0 n)
  ::           =(pop pop.p.dek)
  ::       ==
  ::     [~^~ dek]
  ::   =/  lyn  (rear rop)
  ::   =/  dat  (hydrate-component bom.p.dek q.lyn)
  ::   ?>  ?=(%& -.dat)
  ::   =/  [sal=manx lot=loot]
  ::     =/  rig  (~(got by rigs) p.lyn)
  ::     =/  man
  ::       %~  sail  mast.rig
  ::       :-  (en-scud q.lyn p.p.dat)  [pop loc.p.dek q.p.dat]
  ::     ?.  ?=(%hoot -.man)
  ::       :-  man  (get-loot man)
  ::     %-  take-hoot  +.man
  ::   =.  sal  (haul rop sal)
  ::   =/  dif  (luff rop lot [aft.p.dek ~] [sal ~])
  ::   =^  [bo=(list buoy) jo=(list json)]  q.dek
  ::     %-  ~(rep by q.dek)
  ::     |=  $:  [k=line v=deck]
  ::             a=[[b=(list buoy) j=(list json)] a=(map line deck)]
  ::         ==
  ::     ?:  (~(has in del.p.dif) k)
  ::       %_  a
  ::         b  %+  weld  (unsubscribe-branch (snoc rop k) v)  b.a
  ::       ==
  ::     =/  l  (~(get by lot) k)
  ::     =^  b=[b=(list buoy) j=(list json)]  v
  ::       %=  ^$
  ::         n    +(n)
  ::         rop  (snoc rop k)
  ::         pop  ?~(l ~ u.l)
  ::         dek  v
  ::       ==
  ::     %_  a
  ::       b  %+  weld  b.b  b.a
  ::       j  %+  weld  j.b  j.a
  ::       a  %+  ~(put by a.a)  k  v
  ::     ==
  ::   :-  [(weld boy.p.dif bo) (weld q.dif jo)]
  ::   %_  dek
  ::     p  p.dek(pop pop, aft sal)
  ::     q  (~(uni by q.dek) add.p.dif)
  ::   ==
  ::
  ++  handle-diff-branch-add
    |=  [pre=rope sal=manx]
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
      %^  build-component-branch  pre  r  l
    :-  m
    :-  (~(uni in bos.a) bos.b)
        (~(uni by dek.a) dek.b)
  ::
  :: ++luff
  :: diffs manx into a format that gets sent and applied to sync the client.
  ++  luff
    |=  [rop=rope old=marl new=marl]
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
          |-  ^-  (set rode)
          %+  roll  old
          |=  [m=manx a=(set rode)]
          ?:  ?=([%mast @] n.g.m)
            %-  ~(uni in a)  ^$(old c.m)
          =/  [rod=rode lin=line]  (parse-component-element m)
          %-  ~(put in a)  rod
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
          =^  wak  i.new  (handle-diff-branch-add rop i.new)
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

