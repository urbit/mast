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
:: ++  make-resource-subscription-cards
::   |=  [bas=knot bos=(set buoy)]
::   ^-  (list card)
::   %+  roll  ~(tap in bos)
::   |=  [b=buoy a=(list card)]
::   ?<  ?=(~ q.b)
::   =/  age  i.q.b
::   =/  for  t.q.b
::   :_  a
::   ?-  -.b
::     %add  [%pass (make-component-wire bas b) %agent [our.bowl age] %watch [%r for]]
::     %del  [%pass (make-component-wire bas b) %agent [our.bowl age] %leave ~]
::   ==
::
:: ++  make-component-buoys
::   |=  [act=?(%add %del) rop=rope bom=boom tid=tide]
::   ^-  (list buoy)
::   %+  murn  bom
::   |=  [nam=@tas mak=@tas]
::   =/  paf  (~(get by tid) nam)
::   ?~  paf  ~
::   :^  ~  act  rop  u.paf
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
  |=  p=hook
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
      =.  dock  (~(put by dock) knot.bid [desk.bid name.bid])
      =.  lake  (put-lake desk.bid)
      %-  emit  (make-com-subscription-card %add desk.bid)
    =/  rut  (~(get by lake) [desk.bid name.bid])
    ?~  rut
      ~&  >>>  "%mast-bind failed: {(trip name.bid)} not found"
      !!
    ?.  ?=(%mist -.u.rut)
      ~&  >>>  "%mast-bind failed: {(trip name.bid)} is not a router gate"
      !!
    ~&  >  "%mast-bind: /{(trip knot.bid)} --> {<desk.bid>} {(trip name.bid)}"
    cor
    ::
      %mast-unbind
    =/  not  !<  knot  vase
    =/  duk  (~(get by dock) not)
    ?~  duk
      ~&  >>  "%mast-unbind: /{(trip not)} is already unbound"
      !!
    :: =/  bos
    ::   ^-  (set buoy)
    ::   %-  ~(rep by q.u.duk)
    ::   |=  [[k=rope v=bitt] a=(set buoy)]
    ::   %-  ~(gas in a)  (make-component-buoys %del k bom.v res.v)
    =.  dock  (~(del by dock) not)
    =?  cor  !(dock-has-desk desk.p.u.duk)
      =.  lake  (del-lake desk.p.u.duk)
      %-  emit  (make-com-subscription-card %del desk.p.u.duk)
    ~&  >  "%mast-unbind: /{(trip not)} unbound"
    :: %-  emil
    :: %+  make-resource-subscription-cards  not  bos
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
      
      :: =/  ui-core  (ui-abed:ui bas.kel u.doc)
      :: =^  sal=manx  ui-core  (ui-moor:ui-core [~ src.bowl] kel)
      :: =^  bos=(set buoy)  dock  ui-abet:ui-core
      
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
    
    :: =/  [com=hook blo=blow]  (ui-sway:(ui-abed:ui bas u.doc) rop cro)
    
    %-  emil  (make-gull-cards src.bowl com blo)
    ::
  ==
::
++  agent
  |=  [=wire =sign:agent:gall]
  ^+  cor
  cor
  :: ?+  -.sign  cor
  ::   ::
  ::     %fact
  ::   =/  [bas=knot rop=rope res=path]  (parse-component-wire wire)
  ::   =/  doc  (~(get by dock) bas)
  ::   ?~  doc  ~&(>>> %missing-binding-on-update !!)
  ::   =/  ui-core  (ui-abed:ui bas u.doc)
  ::   =^  [pax=(list path) jon=(list json)]  ui-core  (ui-furl:ui-core rop)
  ::   =^  bos=(set buoy)  dock  ui-abet:ui-core
  ::   %-  emil
  ::   %+  weld  (make-diff-cards bas rop pax jon)
  ::   %+  make-resource-subscription-cards  bas  bos
  ::   ::
  ::     %kick
  ::   =/  [bas=knot rop=rope res=path]  (parse-component-wire wire)
  ::   %-  emil
  ::   %+  make-resource-subscription-cards  bas  [[%add rop res] ~ ~]
  ::   ::
  :: ==
::
++  arvo
  |=  [=wire sign=sign-arvo]
  ^+  cor
  ?+  sign  cor
    ::
      [%clay %writ *]
    ?.  ?=([%lake @ta ~] wire)  cor
    :: reload components on change to a desk's /com
    =.  lake  (del-lake i.t.wire)
    =.  lake  (put-lake i.t.wire)
    %-  emit  (make-com-subscription-card %add i.t.wire)
    ::
  ==
::
:: ++parse-diff-scry-path
:: parse a peek path into two parts:
:: information used to render a component,
:: and a representation of the state of that component on the client.
:: the path has the following syntax:
:: /jam-of-line/node-tag/node-key/node-hash/nested-node-tag...//nested-sibling...////~
++  parse-diff-scry-path
  |=  paf=path
  ^-  [line scud]
  ?>  ?=(^ paf)
  :-  (line (cue (slav %uv i.paf)))
  =/  poe  `(pole @ta)`t.paf
  |-  ^-  scud
  ?~  poe  ~
  ?:  =([~.~ ~] poe)  ~
  ?:  ?=([%$ *] poe)  ~
  ?>  ?=([tag=@ta key=@ta hax=@ta nex=*] poe)
  ?:  ?=([%$ nux=*] nex.poe)
    :_  $(poe nux.poe)
    :*  tag.poe
        key.poe
        hax.poe
        ~
    ==
  =;  nux
    :_  $(poe nux)
    :*  tag.poe
        key.poe
        hax.poe
        $(poe nex.poe)
    ==
  =|  dep=@
  |-  ^+  poe
  ?:  ?=([%$ nux=*] nex.poe)
    ?:  =(0 dep)  nux.poe
    %=  $
      dep  (dec dep)
      poe  nux.poe
    ==
  ?:  ?=([@ta @ta @ta %$ nux=*] nex.poe)
    %=  $
      poe  nux.poe
    ==
  ?>  ?=([@ta @ta @ta nux=*] nex.poe)
  %=  $
    dep  +(dep)
    poe  nex.poe
  ==
::
:: ++parse-component-element
:: extract component data from a component element;
:: the format for a component element is defined in
:: the ++make arm in /sur/mast/hoon
++  parse-component-element
  |=  sal=manx
  ^-  line
  ?>  ?=([%mast @] n.g.sal)
  =|  lin=line
  %_  lin
    -  `hook`=>(=>((stab +.n.g.sal) ?>(?=([@ @ ~] .) [- +<])) ?<(?=(~ .) .))
    +
      %+  roll  a.g.sal
      |=  [[n=mane v=tape] a=[par=gust res=tide]]
      ?+  n  a
        [%gust @]  a(par (~(put by par.a) +.n (crip v)))
        [%gale @]  a(res (~(put by res.a) +.n (scan v stap)))
      ==
  ==
::
:: ++process-sail
:: process a component's rendered sail,
:: adds keys and gathers any component element data
++  process-sail
  |=  [lin=line sal=manx]
  =/  n  0
  =/  com-key  (mug lin)
  =/  prev-key  com-key
  =/  pos-key  *(list @)
  =.  a.g.sal
    :*  [%mast (scot %uv (jam lin))]
        a.g.sal
    ==
  |-  ^-  [pool manx]
  :: temporary: if text node, add text node wrapper
  =?  sal  =(%$ n.g.sal)  ;t-  ;+  sal  ==
  :: handle component elements separately
  ?:  ?=([%mast @] n.g.sal)
    =/  lyn  (parse-component-element sal)
    =/  key  (mug lyn)
    :-  [[key lin] ~ ~]
    :~  [n.g.sal [[%key ((v-co:co 1) key)] ~]]
    ==
  :: also handle client-state elements separately
  ?:  ?=([%client %state] n.g.sal)
    =/  key  `@uw`(mug a.g.sal)
    :-  ~
    %_  sal
      a.g  [[%key ((v-co:co 1) key)] a.g.sal]
    ==
  :: else, if not a component element,
  :: build the current element's key:
  =/  found-key
    ^-  tape
    %+  roll  a.g.sal
    |=  [[n=mane v=tape] a=tape]
    ?:  =(%key n)  v  a
  =/  this-key
    :: for the root element of this component, use this key:
    ?:  =(0 n)  com-key
    :: else this is the key:
    %-  mug  [prev-key pos-key found-key]
  =/  attr-hash
    ?:  =(%t- n.g.sal)
      ?>  ?=([[[%$ [[%$ *] ~]] ~] ~] c.sal)
      %-  mug  v.i.a.g.i.c.sal
    %-  mug  a.g.sal
  =.  a.g.sal
    :+  [%key ((v-co:co 1) this-key)]
        [[%ma %st] ((v-co:co 1) attr-hash)]
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
:: ++luff
:: diffs manx into a format that gets sent and applied to the client.
++  luff
  |=  [lin=line old=scud new=marl]
  =|  i=@ud
  =|  pkey=@t
  =|  acc=diff
  |-  ^-  diff
  ?~  new
    ?~  old  acc
    :_  acc
    %-  swig
    :*  %delete
        %a
        %+  murn  old
        |=  o=$@(@tas [tag=@t key=@t *])
        ?@  o  ~
        :-  ~  [%s key.o]
    ==
  ?:  =(%$ n.g.i.new)  acc
  ?~  old  acc
  ?:  ?=(%skip i.old)
    %=  $
      old  t.old
    ==
  ?:  =(%move- n.g.i.new)
    %=  $
      i    +(i)
      new  t.new
      q.acc
        %+  snoc  q.acc
        %-  swig
        :*  %move
            [%s (getv %key a.g.i.new)]
            [%n (getv %i a.g.i.new)]
        ==
    ==
  =|  j=@ud
  =/  jold=scud  old
  =/  nkey=[n=mane k=@t]  [n.g.i.new (getv %key a.g.i.new)]
  |-  ^-  diff
  :: ?~  new
  ::   !!
  ?~  jold
    %=  ^$
      i    +(i)
      new  t.new
      acc
        :: TODO: handle add case  =/  sal  (handle-diff-branch-add src rop i.new)
        %+  snoc  acc
        %-  swig
        :*  %new
            [%s pkey]
            [%n (scot %ud i)]
            [%s (crip (en-xml:html i.new))]
        ==
    ==
  ?:  ?=(%skip i.jold)
    %=  $
      j     +(j)
      jold  t.jold
    ==
  ?:  =(nkey [tag.i.jold key.i.jold])
    ?.  =(0 j)
      =|  n=@ud
      =/  nnew=marl  new
      =/  okey=[n=mane k=@t]  [tag.i.old key.i.old]
      |-  ^-  diff
      ?~  nnew
        %=  ^^$
          old  (snoc t.old i.old)
        ==
      ?:  =(%move- n.g.i.nnew)
        %=  $
          n     +(n)
          nnew  t.nnew
        ==
      =/  nnky=[n=mane k=@t]  [n.g.i.nnew (getv %key a.g.i.nnew)]
      ?.  =(okey nnky)
        %=  $
          n     +(n)
          nnew  t.nnew
        ==
      ?:  (gte n j)
        %=  ^^$
          old   kid.i.old
          new   c.i.nnew
          pkey  k.nnky
          i     0
          acc
            %=  ^^$
              old  t.old
              new
                %^  snap  new  n
                ;move-(i (y-co:co (add n i)), key (trip k.nnky));
              acc
                ?:  =(hax.i.old (getv [%ma %st] a.g.i.nnew))  acc
                :_  acc
                %-  swig
                :*  %attr
                    [%s k.nnky]
                    [%a (jibe a.g.i.nnew)]
                ==
            ==
        ==
      %=  ^^$
        old   kid.i.jold
        new   c.i.new
        pkey  k.nkey
        i     0
        acc
          %=  ^^$
            i    +(i)
            old  (snap old j %skip)
            new  t.new
            acc
              =.  acc
                %+  snoc  acc
                %-  swig
                :*  %move
                    [%s k.nkey]
                    [%n (scot %ud i)]
                ==
              ?:  =(hax.i.jold (getv [%ma %st] a.g.i.new))  acc
              :_  acc
              %-  swig
              :*  %attr
                  [%s k.nkey]
                  [%a (jibe a.g.i.new)]
              ==
          ==
      ==
    ?:  =(%t- n.g.i.new)
      ?:  ?&  =(%t- tag.i.old)
              =(hax.i.old (getv [%ma %st] a.i.new))
          ==
        %=  ^$
          i    +(i)
          old  t.old
          new  t.new
        ==
      =/  txt=@t
        ?.  &(?=(^ c.i.new) ?=(^ a.g.i.c.i.new))  ''
        %-  crip  v.i.a.g.i.c.i.new
      %=  ^$
        i    +(i)
        old  t.old
        new  t.new
        acc
          :_  acc
          %-  swig
          :*  %text
              [%s (getv %key a.g.i.new)]
              [%s txt]
          ==
      ==
    %=  ^$
      old   kid.i.old
      new   c.i.new
      pkey  k.nkey
      i     0
      acc
        %=  ^$
          i    +(i)
          old  t.old
          new  t.new
          acc
            ?:  =(hax.i.old (getv [%ma %st] a.g.i.new))  acc
            :_  acc
            %-  swig
            :*  %attr
                [%s k.nkey]
                [%a (jibe a.g.i.new)]
            ==
        ==
    ==
  %=  $
    j     +(j)
    jold  t.jold
  ==
::
++  jibe
  |=  mor=mart
  =|  att=[%a [%s k=@t] [%s v=@t] ~]
  ^-  (list _att)
  %+  murn  mor
  |=  [k=mane v=tape]
  ?:  =(%key k)  ~
  :-  ~
  %_  att
    k
      ?@  k  k
      %-  crip
      ;:  weld
        (trip -.k)
        ":"
        (trip +.k)
      ==
    v
      (crip v)
  ==
::
++  getv
  |=  [k=mane m=mart]
  ^-  @t
  ?~  m  ''
  ?:  =(n.i.m k)  (crip v.i.m)
  %=  $
    m  t.m
  ==
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

