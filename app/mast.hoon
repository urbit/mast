/-  *mast
/~  rigs  [=boom =mast]  /com
/*  mast-js  %js  /lib/mast/js
::
:: O╭ ┌┬╮╭─╮╭─╮┌┬┐
:: ╭╯ │││├─┤╰─╮ │
:: ╯O ┴ ┴┴ ┴╰─╯ ┴
::
|%
+$  state-0
  $:  =dock
  ==
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
  :_  this
  :~  (bind-url dap.bowl /mast)
  ==
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
++  on-agent  |=([wire sign:agent:gall] ^-((quip card _this) !!))
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
++  style-node
  ^-  manx
  ;link(rel "stylesheet", href "https://nyc3.digitaloceanspaces.com/drain/hawk/1744044773876.css");
::
++  make-sub-path
  |=  src=@p
  ^-  path
  [%mast (scot %p src) ~]
::
++  bind-url
  |=  [app=@tas url=path]
  ^-  card:agent:gall
  :*  %pass  /bind  %arvo  %e  %connect  [~ url]  app
  ==
::
++  ship-rope-to-wire
  |=  [yon=ship rop=rope]
  ^-  wire
  :-  (scot %p yon)
  (turn rop |=(i=line (spat i)))
::
++  wire-to-ship-rope
  |=  wir=wire
  ^-  [ship rope]
  ?<  ?=(~ wir)
  :-  (slav %p i.wir)
  (turn t.wir |=(i=knot =>((stab i) ?>(?=(^ .) .))))
::
++  parse-channel-data
  |=  jon=json
  ^-  [rope crow]
  =,  dejs:format
  =/  pok
    ^-  [route=rope =path data=(map @t @t)]
    %.  jon
    %-  ot
    :~  route+(ar (ot ~[name+so path+pa]))
        path+pa
        data+(om so)
    ==
  :-  route.pok
  :-  path.pok  data.pok
::
++  make-diff-cards
  |=  [yon=ship jon=(list json)]
  ^-  (list card)
  ?.  .?  jon  ~
  :_  ~
  :*  %give  %fact  [(make-sub-path yon) ~]  %json
      !>  `json`[%a jon]
  ==
::
++  make-resource-subscription-cards
  |=  bos=(list buoy)
  ^-  (list card)
  %+  turn  bos
  |=  i=buoy
  ?-  -.i
      %add
    =/  for  q:(rear q.i)
    :*  %pass  (ship-rope-to-wire +.i)  %arvo  %c
        [%warp our.bowl %base ~ %next %x da+now.bowl for]
    ==
      %del
    :*  %pass  (ship-rope-to-wire +.i)  %arvo  %c
        [%warp our.bowl %base ~]
    ==
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
++  poke
  |=  [=mark =vase]
  ^+  cor
  ?+  mark  ~|(bad-poke/mark !!) 
    ::
      %handle-http-request
    =+  !<  [rid=@ta req=inbound-request:eyre]  vase
    ?+  method.request.req  ~|(bad-method/method.request.req !!)
      ::
        %'GET'
      =/  url  (stab url.request.req)  :: TODO: need better url parsing
      =/  vew  (rear url)
      =/  pax  ?>  ?=([%mast *] url)  (snip t.url)  :: assumes /mast prefix
      =^  [bos=(list buoy) sal=manx]  cor
        ui-gale:ui-open:(ui-abed:ui src.bowl [vew pax])
      =?  sal  !?=(%html n.g.sal)
        ;html
          ;head;
          ;body
            ;+  sal
          ==
        ==
      =/  mar
        ^-  mart
        :~  [%our +:(scow %p our.bowl)]
            [%app (trip dap.bowl)]
            [%sub (spud (make-sub-path src.bowl))]
        ==
      %-  emil
      %+  weld
        %-  make-resource-subscription-cards  bos
      %^  make-direct-http-cards  rid
        [200 ['Content-Type' 'text/html'] ~]
      :-  ~
      %-  as-octt:mimes:html
      %-  en-xml:html
      ?>  ?&  ?=(%html n.g.sal)
              ?=(^ c.sal)
              ?=(%head n.g.i.c.sal)
          ==
      %_  sal
        a.g    (weld a.g.sal mar)
        c.i.c
          ;=
            ;*  c.i.c.sal
            ;+  script-node
            ;+  style-node
          ==
      ==
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
    =/  [rop=rope cro=crow]  (parse-channel-data i.t.p.jon)
    ?<  ?=(~ rop)
    =/  ui-core  (ui-moor:(ui-abed:ui src.bowl i.rop) rop)
    =^  cards  ui-core  (ui-sway:ui-core cro)
    =^  [bos=(list buoy) jon=(list json)]  cor  ui-gust:ui-core
    %-  emil
    %+  weld  (make-diff-cards src.bowl jon)  cards
    ::
  ==
::
++  arvo
  |=  [=wire sign=sign-arvo]
  ^+  cor
  :: ~&  >  :-  %arvo-wire  wire
  :: ~&  >>  :-  %arvo-sign  sign
  ?+  sign  cor
    ::
      [%clay %writ *]
    =/  [yon=ship rop=rope]  (wire-to-ship-rope wire)
    ?<  ?=(~ rop)
    =^  [bos=(list buoy) jon=(list json)]  cor
      ui-gust:(ui-moor:(ui-abed:ui yon i.rop) rop)
    %-  emil
    %+  weld  (make-resource-subscription-cards bos)
    %+  make-diff-cards  yon  jon
    ::
  ==
::
++  ui
  =|  $=  ses  [yon=ship lin=line dek=$@(~ deck)]          :: session
  =|  $=  com  $@(~ [local-update=? rop=rope dek=deck])    :: target component
  =|  $=  fex  wake                                        :: effects
  |%
  ++  ui-core  .
  ::
  ++  ui-abed
    |=  [yon=ship lin=line]
    ^+  ui-core
    =:  yon.ses  yon
        lin.ses  lin
      ==
    =/  duk  (~(get by dock) [yon.ses lin.ses])
    ?~  duk  ui-core
    %_  ui-core
      dek.ses  u.duk
    ==
  ::
  :: ++ui-wake
  :: emit ui effects
  ++  ui-wake
    |=  [s=(list sunk) b=(list buoy) j=(list json)]
    %_  ui-core
      sun.fex  (welp (flop s) sun.fex)
      boy.fex  (welp (flop b) boy.fex)
      jon.fex  (welp j jon.fex)
    ==
  ::
  :: ++ui-open
  :: create a new root branch if one does not exist.
  ++  ui-open
    ^+  ui-core
    ?:  .?  dek.ses  ui-core
    =/  wod  (make-branch lin.ses [lin.ses ~] ~)
    =.  dek.ses  dek.wod
    %:  ui-wake
      sun.wod  boy.wod  ~
    ==
  ::
  :: ++ui-moor
  :: load a component from the session by rope.
  ++  ui-moor
    |=  rop=rope
    ^+  ui-core
    ?<  ?=(~ dek.ses)
    =/  duk  (get-deck rop dek.ses)
    ?~  duk  ui-core
    %_  ui-core
      com  [| rop duk]
    ==
  ::
  :: ++ui-gale
  :: finalize, producing a full page.
  ++  ui-gale
    ^+  [*[(list buoy) manx] cor]
    ?~  dek.ses  [[~ (sunk-page sun.fex)] cor]
    =.  dock  (~(put by dock) [yon.ses lin.ses] dek.ses)
    :_  cor
    :-  boy.fex
    %-  assemble-branch-manx  dek.ses
  ::
  :: ++ui-gust
  :: finalize, rerendering and producing a diff for the loaded component.
  ++  ui-gust
    ^+  [*[(list buoy) (list json)] cor]
    ?<  ?=(~ dek.ses)
    ?~  com
      :_  cor
      :-  boy.fex  ~
    =^  [boy=(list buoy) jon=(list json)]  dek.com
      %:  update-branch
        local-update.com  rop.com  pop.p.dek.com  dek.com
      ==
    =.  dock
      %+  ~(put by dock)  [yon.ses lin.ses]
      %^  put-deck  rop.com  dek.com  dek.ses
    =>  (ui-wake ~ [[%add yon.ses rop.com] boy] jon)
    :_  cor
    :-  boy.fex  jon.fex
  ::
  :: ++ui-sway
  :: apply an event to the loaded component.
  ++  ui-sway
    |=  cro=crow
    ^+  [*(list card) ui-core]
    ?<  ?=(~ com)
    =/  lyn  (rear rop.com)
    =/  rig  (~(got by rigs) p.lyn)
    =/  dat  (hydrate-component bom.p.dek.com q.lyn)
    ?>  ?=(%& -.dat)
    =/  blo
      ^-  blow
      %.  cro
      %~  spar  mast.rig
      :-  (en-scud q.lyn p.p.dat)  [pop.p.dek.com loc.p.dek.com q.p.dat]
    ?~  loc.blo  [caz.blo ui-core]
    :-  caz.blo
    %_  ui-core
      local-update.com  &
      loc.p.dek.com  loc.blo
    ==
  ::
  ++  en-scud
    |=  [pax=path kid=kids]
    ^-  scud
    :*  our.bowl
        yon.ses
        pax
        kid
    ==
  ::
  :: ++sunk-page
  :: produces an error page.
  ++  sunk-page              :: TODO: better error pages
    |=  sun=(list sunk)
    ^-  manx
    ;div
      ;*  %+  turn  sun
          |=  i=sunk
          ^-  manx
          ?-  -.i
              %missing-component-file
            ;div
              ;h1: {<-.i>}
              ;p: {<name.i>}
            ==
              %missing-local-resource
            ;div
              ;h1: {<-.i>}
              ;p: {(spud path.i)}
            ==
              %no-tube
            ;div
              ;h1: {<-.i>}
              ;p: {(spud fil.i)}
              ;p: {<com.i>}
            ==
          ==
    ==
  ::
  :: ++get-deck
  :: gets a branch from a component state tree.
  ++  get-deck
    |=  [rop=rope dek=deck]
    ^-  $@(~ deck)
    ?~  rop  ~
    ?~  t.rop  dek
    =/  nex  (~(get by q.dek) i.t.rop)
    ?~  nex  ~
    %=  $
      rop  t.rop
      dek  u.nex
    ==
  ::
  :: ++put-deck
  :: puts a branch into a component state tree.
  ++  put-deck
    |=  [rop=rope new=deck dek=deck]
    ^-  deck
    ?~  rop  dek
    ?~  t.rop  new
    %_  dek
      q
        %+  ~(put by q.dek)  i.t.rop
        %=  $
          rop  t.rop
          dek  (~(got by q.dek) i.t.rop)
        ==
    ==
  ::
  :: ++take-hoot
  :: process manx:hoot from ++sail:mast.
  :: turns the manx:hoot into regular manx,
  :: and collects any props from component elements.
  ++  take-hoot
    |=  mat=manx:hoot
    ^-  [manx loot]
    =|  lot=loot
    =/  mar=marl:hoot  [mat ~]
    =<  ?>  ?=(^ p)  [i.p q]
    |-  ^-  (pair marl loot)
    %^  spin  mar  lot
    |=  [i=tuna:hoot a=loot]
    ^-  [manx loot]
    ?>  ?=(^ -.i)
    ?.  ?=([%mast @] n.g.i)
      =/  [m=marl b=loot]  ^$(mar c.i)
      :_  (~(uni by a) b)
      :_  m
      :-  n.g.i
      %-  mart  a.g.i
    =;  [paf=(unit tape) pop=prop]
      ?>  ?=(^ paf)
      :-  [[n.g.i [[%path u.paf] ~]] ~]
      %+  ~(put by a)  [+.n.g.i (scan u.paf stap)]  pop
    %+  roll  a.g.i
    |=  $:  [k=mane:hoot v=(list beer:hoot)]
            [pa=(unit tape) po=prop]
        ==
    ^+  [pa po]
    ?:  ?=(%prop k)
      :-  pa
      %-  malt
      %+  turn  v
      |=  ber=beer:hoot
      ^-  [@tas vase]
      ?>  ?&  ?=(^ ber)
              ?=(^ -.p.ber)
              ?=(%rock -.p.p.ber)
              ?=(@ q.p.p.ber)
              ?=(%hand -.q.p.ber)
              ?=(%1 -.q.q.p.ber)
          ==
      :-  q.p.p.ber
      :-  p.q.p.ber  p.q.q.p.ber
    ?:  ?=(%path k)
      :_  po
      :-  ~
      %-  tape  v
    :-  pa  po
  ::
  :: ++get-loot
  :: collects props from any component elements.
  :: this arm is run in place of ++take-hoot when the sail is not hoot mode.
  ++  get-loot
    =|  lot=loot
    |=  man=manx
    ^-  loot
    =?  lot  ?=([%mast @] n.g.man)
      =;  [paf=(unit tape) pop=prop]
        ?>  ?=(^ paf)
        %+  ~(put by lot)  [+.n.g.man (scan u.paf stap)]  pop
      %+  roll  a.g.man
      |=  $:  [k=mane v=tape]
              [pa=(unit tape) po=prop]
          ==
      ?:  ?=(%path k)
        :-  [~ v]  po
      :-  pa
      ?^  k  po
      %+  ~(put by po)  k  !>(v)
    %+  roll  c.man
    |=  [i=manx a=_lot]
    %=  ^$
      man  i
      lot  a
    ==
  ::
  :: ++hydrate-component
  :: scries the namespace for data to supply
  :: to a component.
  ++  hydrate-component
    |=  [bom=boom pax=path]
    ^-  (each (pair kids vase) sunk)
    =/  bym  (bem pax)
    =/  fil
      ^-  (each vase sunk)
      ?:  .=  ~  .^(@uvI %cz bym)
        :-  %|  [%missing-local-resource bym]
      ?:  =(%$ mar.bom)
        :-  %&
        !>  ~
      ?.  .^(? %cu bym)
        :-  %|  [%no-tube pax mar.bom]
      =/  fil  .^(vase %cr bym)
      =/  mar  (rear pax)
      ?:  =(mar mar.bom)
        :-  %&  fil
      =;  con
        ?~  con
          :-  %|  [%no-tube pax mar.bom]
        :-  %&  u.con
      %-  mole                       :: TODO: remove
      |.  ^-  vase
      =/  tub  .^(tube:clay %cc (bem /[mar]/[mar.bom]))
      %-  tub  fil
    ?:  ?=(%| -.fil)
      :-  %|  p.fil
    :-  %&
    :_  p.fil
    .^((list path) %ct bym)
  ::
  :: ++make-branch
  :: creates a component state branch
  :: starting with that of the initial +$line,
  :: recursively creating further nodes based on any
  :: component elements rendered in the parent's sail.
  :: produces effects for resource subscriptions
  :: and component creation errors.
  ++  make-branch
    |=  [new=line rop=rope pop=prop]
    ^-  wood
    =/  rig  (~(get by rigs) p.new)
    ?~  rig
      :-  [%missing-component-file p.new]^~  ~^~
    =/  dat  (hydrate-component boom.u.rig q.new)
    ?:  ?=(%| -.dat)
      :-  p.dat^~  ~^~
    =/  [sal=manx lot=loot]
      =/  man
        %~  sail  mast.u.rig
        :-  (en-scud q.new p.p.dat)  [pop loc.boom.u.rig q.p.dat]
      ?.  ?=(%hoot -.man)
        :-  man  (get-loot man)
      %-  take-hoot  +.man
    =.  sal  (haul rop sal)
    =/  [sun=(list sunk) boy=(list buoy) dak=(map line deck)]
      %-  ~(rep by lot)
      |=  $:  [k=line v=prop]
              [s=(list sunk) b=(list buoy) d=(map line deck)]
          ==
      =;  wod
        :-  (weld s sun.wod)
        :-  (weld b boy.wod)
        ?~  dek.wod  d
        %+  ~(put by d)  k  dek.wod
      %=  ^$
        new  k
        rop  (snoc rop k)
        pop  v
      ==
    =|  cew=clew
    :-  sun
    :-  [[%add yon.ses rop] boy]
    :_  dak
    %_  cew
      fil  (mug q.p.dat)
      kid  p.p.dat
      pop  pop
      loc  loc.boom.u.rig
      bom  boom.u.rig
      aft  sal
    ==
  ::
  :: ++assemble-branch-manx
  :: descends through a branch of component state
  :: and stitches together the full manx of that branch
  :: by replacing each component element with the rendered manx
  :: of the associated component.
  :: if the component is missing from the map of children,
  :: then we assume that it failed to create and skip the element.
  ++  assemble-branch-manx
    |=  dek=deck
    ^-  manx
    =/  mar=marl  [aft.p.dek ~]
    =<  ?>  ?=(^ -)  i
    |-  ^-  marl
    %+  murn  mar
    |=  i=manx
    ^-  (unit manx)
    ?.  ?=([%mast @] n.g.i)
      :-  ~
      %_  i
        c  ^$(mar c.i)
      ==
    =/  paf  (getv %path a.g.i)
    =/  duk  (~(get by q.dek) [+.n.g.i (stab paf)])
    ?~  duk  ~
    :-  ~
    %=  ^^$
      dek  u.duk
    ==
  ::
  ++  unsubscribe-branch
    |=  [r=rope d=deck]
    ^-  (list buoy)
    :-  [%del yon.ses r]
    %-  ~(rep by q.d)
    |=  [[k=line v=deck] a=(list buoy)]
    %+  weld  a
    %=  ^$
      r  (snoc r k)
      d  v
    ==
  ::
  :: ++update-branch
  :: takes a component and its rope
  :: and potentially updates and rerenders it,
  :: and recursively does this for any nested
  :: components.
  ++  update-branch
    =|  n=@
    |=  $:  local-state-change=?
            rop=rope
            pop=prop
            dek=deck
        ==
    ^-  [[(list buoy) (list json)] deck]
    ?:  ?&  !=(0 n)
            =(pop pop.p.dek)
        ==
      [~^~ dek]
    =/  lyn  (rear rop)
    =/  dat  (hydrate-component bom.p.dek q.lyn)
    ?>  ?=(%& -.dat)
    =/  fih  (mug q.p.dat)
    ?:  ?&  !local-state-change  :: infer the update was triggered
            =(0 n)               :: by a change in the state of an
            =(fih fil.p.dek)     :: existing child in the resource's dir.
            =(p.p.dat kid.p.dek) :: this is not cause for a rerender.
        ==
      [~^~ dek]
    =/  [sal=manx lot=loot]
      =/  rig  (~(got by rigs) p.lyn)
      =/  man
        %~  sail  mast.rig
        :-  (en-scud q.lyn p.p.dat)  [pop loc.p.dek q.p.dat]
      ?.  ?=(%hoot -.man)
        :-  man  (get-loot man)
      %-  take-hoot  +.man
    =.  sal  (haul rop sal)
    =/  dif  (luff rop lot [aft.p.dek ~] [sal ~])
    =^  [bo=(list buoy) jo=(list json)]  q.dek
      %-  ~(rep by q.dek)
      |=  $:  [k=line v=deck]
              a=[[b=(list buoy) j=(list json)] a=(map line deck)]
          ==
      ?:  (~(has in del.p.dif) k)
        %_  a
          b  %+  weld  (unsubscribe-branch (snoc rop k) v)  b.a
        ==
      =/  l  (~(get by lot) k)
      =^  b=[b=(list buoy) j=(list json)]  v
        %=  ^$
          n    +(n)
          rop  (snoc rop k)
          pop  ?~(l ~ u.l)
          dek  v
        ==
      %_  a
        b  %+  weld  b.b  b.a
        j  %+  weld  j.b  j.a
        a  %+  ~(put by a.a)  k  v
      ==
    :-  [(weld boy.p.dif bo) (weld q.dif jo)]
    %_  dek
      p  p.dek(fil fih, kid p.p.dat, pop pop, aft sal)
      q  (~(uni by q.dek) add.p.dif)
    ==
  ::
  ++  handle-diff-branch-add
    |=  [rop=rope lot=loot man=manx]
    =|  $=  acc
        $:  des=(map line deck)
            sun=(list sunk)
            boy=(list buoy)
        ==
    =/  mal=marl  [man ~]
    ^-  [_acc manx]
    =<  ?>  ?=(^ p)
        :-  q  i.p
    |-  ^-  (pair marl _acc)
    %^  spin  mal  acc
    |=  [i=manx a=_acc]
    ?:  ?=([%mast @] n.g.i)
      =/  paf  (getv %path a.g.i)
      =/  lin  `line`[+.n.g.i (stab paf)]
      =/  pup  (~(get by lot) lin)
      =/  wod  (make-branch lin (snoc rop lin) ?~(pup ~ u.pup))
      ?~  dek.wod
        :-  i(c [(sunk-page sun.wod) ~])
        %_  a
          sun  (weld sun.a sun.wod)
        ==
      :-  (assemble-branch-manx dek.wod)
      %_  a
        des  (~(put by des.a) lin dek.wod)
        sun  (weld sun.a sun.wod)
        boy  (weld boy.a boy.wod)
      ==
    =^  b=_acc  c.i  =>  ^$(mal c.i)  [q p]
    :-  i
    %_  a
      des  (~(uni by des.a) des.b)
      sun  (weld sun.a sun.b)
      boy  (weld boy.a boy.b)
    ==
  ::
  :: ++haul
  :: applies preprocessing to a component's rendered sail.
  :: primarily adds locational keys to elements without explicit ones
  :: for the sake of diffing in ++luff.
  :: also adds component name attributes to the root.
  ++  haul
    |_  [rop=rope man=manx]                 :: TODO: REFACTOR
    ++  $
      ^-  manx
      =/  lin  (rear rop)
      =/  component-attr  [%component (trip p.lin)]
      =/  path-attr  [%path (spud q.lin)]
      =/  key  (make-component-key rop)
      ?:  ?&  =(%html n.g.man)
              ?=(^ c.man)
              =(%head n.g.i.c.man)
              ?=(^ t.c.man)
              =(%body n.g.i.t.c.man)
          ==
        =.  a.g.i.t.c.man  [component-attr path-attr a.g.i.t.c.man]
        %_  man
          i.t.c  (anx i.t.c.man [key ~])
        ==
      =.  a.g.man  [component-attr path-attr a.g.man]
      %+  anx  man  [key ~]
    ::
    ++  anx
      |=  [m=manx key=(pair tape (list @))]
      ^-  manx
      ?:  ?=([%mast @] n.g.m)
        =/  lin  `line`[+.n.g.m (stab (getv %path a.g.m))]
        =/  com-key  [%key (make-component-key (snoc rop lin))]
        %_  m
          a.g  [com-key a.g.m]
        ==
      =/  fkey
        ^-  @t
        %+  getv  %key  a.g.m
      =/  nkey
        ^-  (pair tape (list @))
        ?:  =('' fkey)  key
        :-  ((w-co:co 1) `@uw`(mug fkey))  ~
      =/  ntap
        ^-  tape
        ?~  q.nkey  p.nkey
        %+  weld  p.nkey  ((w-co:co 1) `@uw`(jam q.nkey))
      ?:  =(%$ n.g.m)
        ;t-
          =key  ntap
          ;+  m
        ==
      %_  m
        a.g
          ^-  mart
          ?.  =('' fkey)  a.g.m
          :-  [%key ntap]  a.g.m
        c
          ?:  ?|  =(%input n.g.m)   =(%textarea n.g.m)
                  =(%script n.g.m)  =(%img n.g.m)
                  =(%link n.g.m)    =(%hr n.g.m)
                  =(%meta n.g.m)    =(%base n.g.m)
              ==
            c.m
          %+  arl  c.m  nkey
      ==
    ::
    ++  arl
      |=  [m=marl key=(pair tape (list @))]
      =|  i=@
      |-  ^-  marl
      ?~  m  ~
      :-  %+  anx
            i.m
          key(q [i q.key])
      $(m t.m, i +(i))
    ::
    ++  make-component-key
      |=  rop=rope
      ((w-co:co 1) `@uw`(mug rop))
    ::
    --
  ::
  :: ++luff
  :: diffs manx into a format that gets sent and applied to sync the client.
  ++  luff
    |=  [rop=rope lot=loot old=marl new=marl]
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
          %-  ~(gas in del.p.acc)
          %+  roll  `marl`old
          |=  [m=manx a=(list line)]
          ?.  ?=([%mast @] n.g.m)  a
          =/  paf  (stab (getv %path a.g.m))
          :-  `line`[+.n.g.m paf]  a
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
          =^  fec  i.new
            %^  handle-diff-branch-add  rop  lot  i.new
          %_  acc
            boy.p  (weld boy.p.acc boy.fec)
            add.p  (~(uni by add.p.acc) des.fec)
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

