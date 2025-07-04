/-  *mast
/*  mast-js  %js  /lib/mast/js
::
:: O╭ ┌┬╮╭─╮╭─╮┌┬┐
:: ╭╯ │││├─┤╰─╮ │
:: ╯O ┴ ┴┴ ┴╰─╯ ┴
::
|%
+$  state-0
  $:  swab=@da
      =navy
      =dock
      =deck
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
++  cleanup-timer
  =/  tim  `@da`(add ~d1 now.bowl)
  =/  wir  `wire`/cleanup
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
  ^-  [path quay]
  :: TODO: better url parsing
  =/  url  (stab cod)
  =.  url  ?>  ?=([%mast *] url)  t.url  :: temporary: assumes /mast prefix
  :-  url  ~
::
++  parse-channel-data
  |=  jon=json
  ^-  [path quay line crow]
  =,  dejs:format
  =+  ^-  [rut=cord com=cord eve=path dat=(map @t @t)]
      %.  jon
      %-  ot
      :~  url+so
          com+so
          path+pa
          data+(om so)
      ==
  =/  [url=path que=quay]  (parse-url rut)
  :+  url  que
  :-  (line (cue (slav %uv com)))
  :-  eve  dat
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
  :*  %pass  /deck/[des]  %arvo  %c
      %warp  our.bowl  des
      ?-  act
        %add  [~ %next %z da+now.bowl /com]
        %del  ~
      ==
  ==
::
++  make-resource-subscription-card
  |=  boy=buoy
  ^-  card
  ?<  ?=(~ p.boy)
  :: the %mast agent subscribes to an on-watch path
  :: in the agent specified in the first path segment.
  =/  age  i.p.boy
  =/  for  t.p.boy
  =/  wir  [%res p.boy]
  ?-  -.boy
    %add  [%pass wir %agent [our.bowl age] %watch [%r for]]
    %del  [%pass wir %agent [our.bowl age] %leave ~]
  ==
::
++  handle-com-resource-adds
  |=  [com=@t res=(list path)]
  ^+  cor
  ?~  res  cor
  =/  sus  (~(get by navy) i.res)
  ?^  sus
    %=  $
      res  t.res
      navy  (~(put by navy) i.res (~(put in u.sus) [src.bowl com]))
    ==
  =.  cor  (emit (make-resource-subscription-card [%add i.res]))
  %=  $
    res  t.res
    navy  (~(put by navy) i.res (silt [[src.bowl com] ~]))
  ==
::
++  handle-com-resource-dels
  |=  [com=@t res=(list path)]
  ^+  cor
  ?~  res  cor
  =/  sus  (~(get by navy) i.res)
  ?~  sus
    %=  $
      res  t.res
    ==
  =.  u.sus  (~(del in u.sus) [src.bowl com])
  ?^  u.sus
    %=  $
      res  t.res
      navy  (~(put by navy) i.res u.sus)
    ==
  =.  cor  (emit (make-resource-subscription-card [%del i.res]))
  %=  $
    res  t.res
    navy  (~(del by navy) i.res)
  ==
::
++  dock-has-desk
  |=  des=desk
  ^-  ?
  %-  ~(any by dock)
  |=  lin=line
  .=  desk.com.lin  des
::
++  put-deck
  |=  des=desk
  =/  fis  .^((list path) %ct (bam des /com))
  |-  ^-  ^deck
  ?~  fis  deck
  ~&  (bam des i.fis)
  =/  fil  .^(vase %ca (bam des i.fis))
  =/  huk  `hook`[des (rear (snip i.fis))]
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
++  del-deck
  |=  des=desk
  ^-  ^deck
  %-  malt
  %+  skip  ~(tap by deck)
  |=  [k=hook *]
  .=  des  desk.k
::
++  init
  =.  cor  set:cleanup-timer
  %-  emil
  :~  (bind-url dap.bowl /mast)
  ==
::
++  save
  ^-  vase
  !>  state(deck ~)
::
++  load
  |=  =vase
  ^+  cor
  =/  lod  !<  state-n  vase
  ?-  -.lod
    ::
      %state-0
    =.  state  lod
    =.  cor  reset:cleanup-timer
    =/  des
      ^-  (list desk)
      %~  tap  in
      ^-  (set desk)
      %-  ~(rep by dock)
      |=  [[k=knot v=line] a=(set desk)]
      %-  ~(put in a)  desk.com.v
    |-  ^+  cor
    ?~  des  cor
    =.  deck  (put-deck i.des)
    =.  cor  (emit (make-com-subscription-card %add i.des))
    %=  $
      des  t.des
    ==
    ::
  ==
::
++  arvo
  |=  [=wire sign=sign-arvo]
  ^+  cor
  ?+  sign  cor
    ::
      [%clay %writ *]
    ?.  ?=([%deck @ta ~] wire)  cor
    :: reload components on change to a desk's /com
    =.  deck  (del-deck i.t.wire)
    =.  deck  (put-deck i.t.wire)
    %-  emit  (make-com-subscription-card %add i.t.wire)
    ::
      [%behn %wake *]
    ?+  wire  !!
      ::
        [%cleanup ~]
      =.  cor  set:cleanup-timer
      ?^  error.sign  cor
      =/  hav
        %+  roll  ~(val by sup.bowl)
        |=  [[who=ship paf=path] acc=(set (pair ship cord))]
        ::  /com/[client-ship]/[com-id]
        ?.  ?=([%com @ @ ~] paf)  acc
        %+  ~(put in acc)  (slav %p i.t.paf)  i.t.t.paf
      =^  caz=(list card)  navy
        %-  ~(rep by navy)
        |=  $:  [key=path val=(set (pair ship cord))]
                acc=[caz=(list card) new=^navy]
            ==
        =/  kil  (~(dif in val) hav)
        =/  liv  (~(dif in val) kil)
        ?^  liv
          %_  acc
            new  (~(put by new.acc) key liv)
          ==
        %_  acc
          caz  [(make-resource-subscription-card [%del key]) caz.acc]
        ==
      %-  emil  caz
      ::
    ==
    ::
  ==
::
++  agent
  |=  [=wire =sign:agent:gall]
  ^+  cor
  ?+  wire  cor
    ::
      [%res *]
    ?>  ?=(^ +.wire)
    ?+  -.sign  cor
      ::
        %fact
      =/  sus  (~(get by navy) +.wire)
      ?~  sus  ~&(>>> %missing-navy !!)
      %-  emil
      %-  ~(rep in u.sus)
      |=  [[src=ship com=cord] caz=(list card)]
      :_  caz
      :*  %give  %fact  [/com/[(scot %p src)]/[com] ~]  [%json !>([%s com])]
      ==
      ::
        %kick
      %-  emit
      %-  make-resource-subscription-card  [%add +.wire]
      ::
    ==
    ::
  ==
::
++  watch
  |=  poe=(pole @ta)
  ^+  cor
  ?+  poe  cor
    ::
      [%com src=@ta com=@ta ~]
    ?>  =(src.bowl (slav %p src.poe))
    =/  lin  (line (cue (slav %uv com.poe)))
    %+  handle-com-resource-adds  com.poe  ~(val by res.lin)
    ::
  ==
::
++  leave
  |=  poe=(pole @ta)
  ^+  cor
  ?+  poe  !!
    ::
      [%com src=@ta com=@ta ~]
    ?>  =(src.bowl (slav %p src.poe))
    =/  lin  (line (cue (slav %uv com.poe)))
    %+  handle-com-resource-dels  com.poe  ~(val by res.lin)
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
    ?:  (~(has by dock) p.bid)
      ~&  >>>  "%mast-bind failed: /{(trip p.bid)} already exists"
      !!
    =?  cor  !(dock-has-desk desk.com.q.bid)
      =.  deck  (put-deck desk.com.q.bid)
      %-  emit  (make-com-subscription-card %add desk.com.q.bid)
    =.  dock  (~(put by dock) bid)
    ~&  >  "%mast-bind: /{(trip p.bid)} --> {<desk.com.q.bid>} {(trip name.com.q.bid)}"
    cor
    ::
      %mast-unbind
    =/  not  !<  knot  vase
    =/  duk  (~(get by dock) not)
    ?~  duk
      ~&  >>  "%mast-unbind: /{(trip not)} is already unbound"
      !!
    =.  dock  (~(del by dock) not)
    =?  cor  !(dock-has-desk desk.com.u.duk)
      =.  deck  (del-deck desk.com.u.duk)
      %-  emit  (make-com-subscription-card %del desk.com.u.duk)
    ~&  >  "%mast-unbind: /{(trip not)} unbound"
    cor
    ::
      %handle-http-request
    =+  !<  [rid=@ta req=inbound-request:eyre]  vase
    ?+  method.request.req  ~|(bad-method/method.request.req !!)
      ::
        %'GET'
      =/  [url=path que=quay]  (parse-url url.request.req)
      ?~  url
        %-  emil
        %-  make-404-res  rid
      =/  lun  (~(get by dock) i.url)
      %-  emil
      ?~  lun
        %-  make-404-res  rid
      %^  make-direct-http-cards  rid  [200 ['Content-Type' 'text/html'] ~]
      :-  ~
      %-  as-octt:mimes:html
      %-  en-xml:html
      %^  render-full  url  que  u.lun
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
    =/  [url=path que=quay lin=line cro=crow]  (parse-channel-data i.t.p.jon)
    %-  emil
    %^  make-gull-cards  src.bowl  com.lin
    %:  apply-event  url  que  lin  cro
    ==
    ::
  ==
::
++  peek
  |=  poe=(pole @ta)
  ^-  (unit (unit cage))
  ?+  poe  ~
    ::
      [%x %diff rest=*]
    =/  iel  (parse-diff-scry-path rest.poe)
    =/  com  (~(got by deck) com.lin.iel)
    =/  sal  ~(sail +.com (make-hull url.iel que.iel boom.com lin.iel))
    :+  ~  ~
    :-  %json
    !>  `json`[%a (luff url.iel que.iel lin.iel lot.iel [(process-sail lin.iel sal) ~])]
    ::
  ==
::
:: ++parse-diff-scry-path
:: parse a peek path into two parts:
:: information used to render a component,
:: and a representation of the state of that component on the client.
:: the path has the following syntax:
:: /url/jam-of-line/node-tag/node-key/node-hash/nested-node-tag...//nested-sibling...////~
++  parse-diff-scry-path
  |=  paf=path
  ^-  isle
  ?>  ?=([@ ^] paf)
  =+  ;;([url=path que=quay] (cue (slav %uv i.paf)))
  :^  url
      que
      (line (cue (slav %uv i.t.paf)))
  =/  poe  `(pole @ta)`t.t.paf
  |-  ^-  loot
  ?~  poe  ~
  ?:  =([~.~ ~] poe)  ~
  ?:  ?=([%$ *] poe)  ~
  ?>  ?=([tag=@ta key=@ta hax=@ta nex=*] poe)  :: TODO: remove tag. path parsing will crash on cell mane
  ?:  ?=([%$ nux=*] nex.poe)
    :_  $(poe nux.nex.poe)
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
  |-  ^+  nex.poe
  ?:  ?=([%$ nux=*] nex.poe)
    ?:  =(0 dep)  nux.nex.poe
    %=  $
      dep  (dec dep)
      nex.poe  nux.nex.poe
    ==
  ?:  ?=([@ta @ta @ta %$ nux=*] nex.poe)
    %=  $
      nex.poe  nux.nex.poe
    ==
  ?>  ?=([@ta @ta @ta nux=*] nex.poe)
  %=  $
    dep  +(dep)
    nex.poe  nux.nex.poe
  ==
::
:: ++parse-component-element
:: extract component data from a component element;
:: the format for a component element is defined in
:: the ++make arm in /sur/mast/hoon
++  parse-component-element
  |=  sal=manx
  ^-  line
  ?>  ?=(%mast n.g.sal)
  %+  roll  a.g.sal
  |=  [[n=mane v=tape] a=line]
  ?+  n  a
    [%hook @]  a(com [+.n (crip v)])
    [%gust @]  a(par (~(put by par.a) +.n (crip v)))
    [%gale @]  a(res (~(put by res.a) +.n (scan v stap)))
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
    :*  [%mast (scow %uv (jam lin))]
        a.g.sal
    ==
  |-  ^-  manx
  :: temporary: if text node, add text node wrapper
  =?  sal  =(%$ n.g.sal)  ;t-  ;+  sal  ==
  :: handle component elements separately
  ?:  ?=(%mast n.g.sal)
    :: this key must correspond to the key of the component's root element
    =/  key  (mug (parse-component-element sal))
    %_  sal
      a.g  [[%key ((v-co:co 1) key)] [[%ma %st] "0"] a.g.sal]
    ==
  :: also handle client-state elements separately
  ?:  ?=([%client-state] n.g.sal)
    =/  key  `@uw`(mug a.g.sal)
    %_  sal
      a.g  [[%key ((v-co:co 1) key)] [[%ma %st] "0"] a.g.sal]
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
    ?~  a.g.sal  0
    %-  mug  a.g.sal
  =.  a.g.sal
    :+  [%key ((v-co:co 1) this-key)]
        [[%ma %st] ((v-co:co 1) attr-hash)]
    ?~  found-key  a.g.sal
    %+  skip  a.g.sal
    |=  [n=mane v=tape]
    .=  %key  n
  :: don't recurse for these elements:
  ?:  ?|  =(%t- n.g.sal)
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
++  hydrate-component
  |=  [bom=boom res=rode]
  ^-  gale
  %-  malt
  %+  murn  bom
  |=  [nam=@tas mak=@tas]
  ^-  (unit [term path vase])
  =/  paf  (~(get by res) nam)
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
++  make-hull
  |=  [url=path que=quay bom=boom lin=line]
  ^-  hull
  ?>  ?=(^ url)
  :*  our.bowl
      src.bowl
      now.bowl
      eny.bowl
      i.url
      t.url
      que
      par.lin
      (hydrate-component bom res.lin)
  ==
::
++  apply-event
  |=  [url=path que=quay lin=line cro=crow]
  ^-  blow
  =/  com  (~(got by deck) com.lin)
  %.  cro
  %~  spar  +.com  (make-hull url que boom.com lin)
::
++  render-full
  |=  [url=path que=quay lin=line]
  ^-  manx
  =/  com  (~(got by deck) com.lin)
  =/  doc  ~(sail +.com (make-hull url que boom.com lin))
  :: assert that the product of the sail arm
  :: is a complete document of the following structure:
  ?.  ?&  ?=([* * ~] c.doc)
          ?=(%html n.g.doc)
          ?=(%head n.g.i.c.doc)
          ?=(%body n.g.i.t.c.doc)
      ==
    ~&  >>>  [%malformed-root-component com.lin]
    !!
  %_  doc
    a.g
      :~  [%our +:(scow %p our.bowl)]
          [%src (scow %p src.bowl)]
          [%uvurl (scow %uv (jam [url que]))]  :: TODO: find a less stupid solution
      ==
    c.i.c  [script-node c.i.c.doc]
    i.t.c
      =<  ?>(?=(%body n.g) .)
      %^  handle-component-elements  url  que
      %+  process-sail  lin  i.t.c.doc
  ==
::
++  handle-component-elements
  |=  [url=path que=quay sal=manx]
  ^-  manx
  =<  ?>  ?=(^ .)
      i
  =/  mal  `marl`[sal ~]
  |-  ^-  marl
  %+  turn  mal
  |=  i=manx
  ?.  ?=(%mast n.g.i)
    %_  i
      c  ^$(mal c.i)
    ==
  =/  lin  (parse-component-element i)
  =/  com  (~(got by deck) com.lin)
  =/  sal  ~(sail +.com (make-hull url que boom.com lin))
  =.  sal  (process-sail lin sal)
  %_  sal
    c  ^$(mal c.sal)
  ==
::
:: ++luff
:: diffs manx into a format that gets sent and applied to the client.
++  luff
  |=  [url=path que=quay lin=line old=loot new=marl]
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
  ?:  &(?=(^ old) ?=(%skip i.old))
    %=  $
      old  t.old
    ==
  ?:  =(%move- n.g.i.new)
    %=  $
      i    +(i)
      new  t.new
      acc
        %+  snoc  acc
        %-  swig
        :*  %move
            [%s (getv %key a.g.i.new)]
            [%n (getv %i a.g.i.new)]
        ==
    ==
  =|  j=@ud
  =/  jold=loot  old
  =/  nkey=[n=mane k=@t]  [n.g.i.new (getv %key a.g.i.new)]
  |-  ^-  diff
  ?~  jold
    %=  ^$
      i    +(i)
      new  t.new
      acc
        %+  snoc  acc
        %-  swig
        :*  %new
            [%s pkey]
            [%n (scot %ud i)]
            [%s (crip (en-xml:html (handle-component-elements url que i.new)))]
        ==
    ==
  ?<  |(?=(~ old) ?=(%skip i.old))
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
                %^  snap  `marl`new  n
                ^-  manx
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
            old  (snap `loot`old j `gold`%skip)
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
              =(hax.i.old (getv [%ma %st] a.g.i.new))
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
  %+  turn  mor
  |=  [k=mane v=tape]
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
    %attr
      :~  ['p' [%s 'c']]
          ['q' key.jif]
          ['r' new.jif]
      ==
    %text
      :~  ['p' [%s 't']]
          ['q' container-key.jif]
          ['r' data.jif]
      ==
  ==
::
--

