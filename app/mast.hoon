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
  --
::
--

