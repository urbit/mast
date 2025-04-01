/-  *mast
/~  rigs  [=boom =mast]  /com
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
++  bind-url
  |=  [app=@tas url=path]
  ^-  card:agent:gall
  :*  %pass  /bind  %arvo  %e  %connect  [~ url]  app
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
      ~&  >  vew
      ~&  >  pax
      =/  ui-core  (ui-abed:ui src.bowl [vew pax])
      !!
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
  |_  [yon=ship lin=line lak=lake dek=deck]
  ++  ui-core  .
  ++  ui-subs  |=  =lake  ui-core(lak (welp (flop lake) lak))
  ++  ui-abed
    |=  [y=_yon l=_lin]
    ^+  ui-core
    =:  yon  y
        lin  l
      ==
    =/  duk  (~(get by dock) [yon lin])
    ?^  duk
      %_  ui-core
        dek  u.duk
      ==
    =^  subs  dek  (make-branch lin ~)
    =.  dock  (~(put by dock) [yon lin] dek)
    %-  ui-subs  subs
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
  ++  hydrate-component
    |=  [bom=boom pax=path]
    ^-  (unit (pair kids vase))
    =/  bym  (bem pax)
    =/  fil
      ^-  (unit vase)
      ?.  .^(? %cu bym)
        :-  ~
        !>  ~
      =/  fil  .^(vase %cr bym)
      =/  mak  (rear pax)
      ?:  =(mak mar.bom)
        :-  ~  fil
      %-  mole
      |.  ^-  vase
      =/  tub  .^(tube:clay %cc (bem /[mak]/[mar.bom]))
      %-  tub  fil
    ?~  fil  ~
    :-  ~
    :_  u.fil
    .^((list path) %ct bym)
  ::
  ++  make-branch
    |=  [new=line pop=prop]
    ^-  [lake deck]
    ~^*deck
  ::
  :: ++haul
  :: apply preprocessing to a component's rendered sail.
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
--

