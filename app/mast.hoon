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
++  rope-to-wire
  |=  rop=rope
  ^-  wire
  (turn rop |=(i=line (spat i)))
::
++  wire-to-rope
  |=  wir=wire
  ^-  rope
  (turn wir |=(i=knot =>((stab i) ?>(?=(^ .) .))))
::
++  make-resource-subscription
  |=  rop=rope
  ^-  card
  =/  for  q:(rear rop)
  [%pass (rope-to-wire rop) %arvo %c [%warp our.bowl %base ~ %next %x da+now.bowl for]]
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
      ~&  >  vew
      ~&  >  pax
      =^  sal  cor  ui-gale:ui-open:(ui-abed:ui src.bowl [vew pax])
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
      %^    make-direct-http-cards
          rid
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
        c.i.c  (snoc c.i.c.sal script-node)
      ==
      ::
    ==
    ::
  ==
::
++  arvo
  |=  [=wire sign=sign-arvo]
  ^+  cor
  ~&  >  wire
  ~&  >>  sign
  ?+  sign  cor
    ::
      [%clay %writ ^]
    ~&  >>>  r.u.p.sign
    cor
    ::
  ==
::
++  ui
  |_  [yon=ship lin=line wak=wake]
  ::
  ++  ui-core  .
  ::
  ++  ui-abed
    |=  [y=_yon l=_lin]
    ^+  ui-core
    =:  yon  y
        lin  l
      ==
    =/  duk  (~(get by dock) [yon lin])
    ?~  duk  ui-core
    %_  ui-core
      dek.wak  u.duk
    ==
  ::
  :: ++ui-buoy
  :: add resource subscription changes.
  ++  ui-buoy
    |=  b=(list buoy)
    %_  ui-core
      boy.wak  (welp (flop b) boy.wak)
    ==
  ::
  :: ++ui-open
  :: create a new root branch if one does not exist.
  ++  ui-open
    ^+  ui-core
    ?^  dek.wak  ui-core
    %_  ui-core
      wak  (make-branch lin [lin ~] ~)
    ==
  ::
  :: ++ui-gale
  :: finalize, producing a full page.
  ++  ui-gale
    ^+  [*manx cor]
    ?~  dek.wak
      :-  sunk-page  cor
    =.  dock  (~(put by dock) [yon lin] dek.wak)
    :_  cor
    %-  assemble-branch-manx  dek.wak
  ::
  ++  en-scud
    |=  [pax=path kid=kids]
    ^-  scud
    :*  our.bowl
        yon
        pax
        kid
    ==
  ::
  :: ++sunk-page
  :: produces an error page
  :: for when the root component fails to create.
  ++  sunk-page              :: TODO: better error pages
    ^-  manx
    ;div
      ;*  %+  turn  sun.wak
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
    =;  [key=(unit tape) pop=prop]
      ?>  ?=(^ key)
      :-  [[n.g.i [[%key u.key] ~]] ~]
      %+  ~(put by a)  [+.n.g.i (scan u.key stap)]  pop
    %+  roll  a.g.i
    |=  $:  [k=mane:hoot v=(list beer:hoot)]
            [ke=(unit tape) po=prop]
        ==
    ^+  [ke po]
    ?:  ?=(%prop k)
      :-  ke
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
    ?:  ?=(%key k)
      :_  po
      :-  ~
      %-  tape  v
    :-  ke  po
  ::
  :: ++get-loot
  :: collects props from any component elements.
  :: this arm is run in place of ++take-hoot when the sail is not hoot mode.
  ++  get-loot
    =|  lot=loot
    |=  man=manx
    ^-  loot
    =?  lot  ?=([%mast @] n.g.man)
      =;  [key=(unit tape) pop=prop]
        ?>  ?=(^ key)
        %+  ~(put by lot)  [+.n.g.man (scan u.key stap)]  pop
      %+  roll  a.g.man
      |=  $:  [k=mane v=tape]
              [ke=(unit tape) po=prop]
          ==
      ?:  ?=(%key k)
        :-  [~ v]  po
      :-  ke
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
    ^-  wake
    =/  com  (~(get by rigs) p.new)
    ?~  com
      :-  [%missing-component-file p.new]^~  ~^~
    =/  dat  (hydrate-component boom.u.com q.new)
    ?:  ?=(%| -.dat)
      :-  p.dat^~  ~^~
    =/  [sal=manx lot=loot]
      =/  man
        %~  sail  mast.u.com
        :-  (en-scud q.new p.p.dat)  [pop loc.boom.u.com q.p.dat]
      ?.  ?=(%hoot -.man)
        :-  man  (get-loot man)
      %-  take-hoot  +.man
    =.  sal  (haul new sal)
    =/  [sun=(list sunk) boy=(list buoy) dak=(map line deck)]
      %-  ~(rep by lot)
      |=  $:  [k=line v=prop]
              [s=(list sunk) b=(list buoy) d=(map line deck)]
          ==
      =;  wak=wake
        :-  (weld s sun.wak)
        :-  (weld b boy.wak)
        ?~  dek.wak  d
        %+  ~(put by d)  k  dek.wak
      %=  ^$
        new  k
        rop  (snoc rop k)
        pop  v
      ==
    =|  cew=clew
    :-  sun
    :-  [[%add rop] boy]
    :_  dak
    %_  cew
      pop  pop
      loc  loc.boom.u.com
      bom  boom.u.com
      aft  sal
    ==
  ::
  ++  unsubscribe-branch
    =|  acc=(list buoy)
    |=  [r=rope d=deck]
    ^-  (list buoy)
    :: TODO: go through deck and build rope; at each component, add a %del to buoy
    !!
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
    =/  key  (getv %key a.g.i)
    =/  com  (~(get by q.dek) [+.n.g.i (stab key)])
    ?~  com  ~
    :-  ~
    %=  ^^$
      dek  u.com
    ==
  ::
  :: ++haul
  :: applies preprocessing to a component's rendered sail.
  :: primarily adds locational keys to elements without explicit ones
  :: for the sake of diffing in ++luff.
  :: also adds component name attributes to the root.
  ++  haul
    |_  [lin=line man=manx]
    ++  $
      ^-  manx
      =/  component-attr  [%component (trip p.lin)]
      ?:  ?&  =(%html n.g.man)
              ?=(^ c.man)
              =(%head n.g.i.c.man)
              ?=(^ t.c.man)
              =(%body n.g.i.t.c.man)
          ==
        =.  a.g.i.t.c.man  [component-attr a.g.i.t.c.man]
        %_  man
          i.t.c  (anx i.t.c.man ["" ~])
        ==
      =.  a.g.man  [component-attr a.g.man]
      %+  anx  man  [(spud q.lin) ~]
    ++  anx
      |=  [m=manx key=(pair tape (list @))]
      ^-  manx
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
    ++  arl
      |=  [m=marl key=(pair tape (list @))]
      =|  i=@
      |-  ^-  marl
      ?~  m  ~
      :-  %+  anx
            i.m
          key(q [i q.key])
      $(m t.m, i +(i))
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
      =/  dels
        ^-  (list [n=mane k=@t])
        %+  turn  old
        |=  m=manx  [n.g.m (getv %key a.g.m)]
      %_  acc
        del.p
          %-  ~(gas in del.p.acc)
          %+  roll  dels
          |=  [[n=mane k=@t] a=(list line)]
          ?.  ?=([%mast @] n)  a
          :-  [+.n (stab k)]  a
        q
          :_  q.acc
          %-  swig
          :*  %delete
              [%a (turn dels |=([* k=@t] [%s k]))]
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
          ?.  ?=([%mast @] n.g.i.new)
            %_  acc
              q
                %+  snoc  q.acc
                %-  swig
                :*  %new
                    [%s pkey]
                    [%n (scot %ud i)]
                    [%s (crip (en-xml:html i.new))]
                ==
            ==
          =/  lin  `line`[+.n.g.i.new (stab k.nkey)]
          =/  pup  (~(get by lot) lin)
          =/  wac  (make-branch lin (snoc rop lin) ?~(pup ~ u.pup))  :: TODO: print any sunk
          ?~  dek.wac  !!  :: TODO: handle branch create fail
          %_  acc
            boy.p  (weld boy.p.acc boy.wac)
            add.p  (~(put by add.p.acc) lin dek.wac)
            q
              %+  snoc  q.acc
              %-  swig
              :*  %new
                  [%s pkey]
                  [%n (scot %ud i)]
                  [%s (crip (en-xml:html (assemble-branch-manx dek.wac)))]
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

