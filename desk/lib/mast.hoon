/*  mast-js  %js  /lib/mast/js
|%
::
+$  crow                                         :: client events
  $%  [%poke =path data=(map @t @t)]             ::
      [%open req=inbound-request:eyre]           ::
  ==                                             ::
+$  blow                                         :: event effects
  $:  p=(unit path)                              ::   change session route state
      q=(unit cage)                              ::   forward a poke to the agent
  ==                                             ::
+$  name  term                                   :: component name
+$  dock  (list [name mast])                     :: component list
+$  deck  (map name mast)                        :: component map
+$  hull  agent:gall                             :: nested agent
+$  bowl  bowl:gall                              :: bowl
+$  stay  [=path =bowl]                          :: component context (route+bowl)
+$  sack  vase                                   :: component props state
+$  stow  vase                                   :: local component state
+$  mast                                         :: component core
  $_  ^|                                         ::
  |_  [stay sack stow]                           ::
  ++  scud  *(unit *)                            ::
  ++  spar  *$-(crow [blow stow])                ::
  ++  sail  *$^([%hoot manx:hoot] manx)          ::
  --                                             ::
+$  rigs                                         :: session state by source
  %+  map  ship                                  ::
  $:  =path                                      ::
      =rope                                      ::
  ==                                             ::
+$  rope                                         :: component instance tree
  $~  [*wood ~]                                  ::
  %+  pair  wood                                 ::
  %+  map  clew  rope                            ::
+$  clew  [=name key=@t]                         :: component instance id
+$  tack  (list clew)                            :: component instance path
+$  wood                                         :: component instance state
  $:  sud=atom                                   ::   prev scud hash
      sow=stow                                   ::   local state
      sac=sack                                   ::   props state
      aft=manx                                   ::   prev manx
  ==                                             ::
+$  diff  (list json)                            :: luff diff prod
+$  card  card:agent:gall                        :: card
+$  brig                                         :: %mast internal state
  $:  =rigs
  ==
::
++  wrap
  |=  [=deck =hull]
  ^-  agent:gall
  =|  =brig
  =<
  |_  =bowl
  +*  this  .
      hu  ~(. hull bowl)
  ::
  ++  on-init
    ^-  (quip card _this)
    =^  cards  hull  on-init:hu
    :-  cards  this
  ::
  ++  on-save   on-save:hu
  ::
  ++  on-load
    |=  =vase
    ^-  (quip card _this)
    =^  cards  hull  (on-load:hu vase)
    :-  cards  this
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?+  mark
      ::
      =^  cards  hull  (on-poke:hu [mark vase])
      :-  cards  this
      ::
        %handle-http-request
      =+  !<([rid=@ta req=inbound-request:eyre] vase)
      ?+  method.request.req
        ::
        :: TODO: make handle-http-request fall through to hull
        ~|(bad-method/method.request.req !!)
        ::
          %'GET'
        =^  cards  rigs.brig  (gale rid req bowl)
        :-  cards  this
        ::
      ==
      ::
        %json
      :: TODO: gust
      `this
      :: =+  !<  jon=json  vase
      :: ?.  ?&  ?=(%a -.jon)
      ::         ?=(^ p.jon)
      ::         ?=(^ t.p.jon)
      ::         =([%s 'mast'] i.p.jon)
      ::     ==
      ::   =^  cards  hull  (on-poke:hu [mark vase])
      ::   :-  cards  this
      :: =/  =crow  (parse-channel-data i.t.p.jon)
      :: =^  cards  hull  (on-poke:hu [%mast-event !>(crow)])
      :: :-  cards  this
      ::
    ==
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card _this)
    ?:  ?=([%http-response *] path)
      [~ this]
    ?:  ?=([%mast @ta ~] path)           :: TODO:
      ?>  =(src.bowl (slav %p i.t.path))
      [~ this]
    =^  cards  hull  (on-watch:hu path)
    :-  cards  this
  ::
  ++  on-leave
    |=  =path
    ^-  (quip card _this)
    =^  cards  hull  (on-leave:hu path)
    :-  cards  this
  ::
  ++  on-peek   on-peek:hu
  ::
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    ^-  (quip card _this)
    =^  cards  hull  (on-agent:hu wire sign)
    :-  cards  this
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    =^  cards  hull  (on-arvo:hu wire sign-arvo)
    :-  cards  this
  ::
  ++  on-fail
    |=  [=term =tang]
    ^-  (quip card _this)
    =^  cards  hull  (on-fail:hu term tang)
    :-  cards  this
  ::
  --
  ::
  |%
  ::
  ++  gale
    |=  [rid=@ta req=inbound-request:eyre =bowl]
    ^-  (quip card rigs)
    `*rigs
  ::
  ++  gust
    ^-  (quip card ^deck)
    :: TODO:
    `deck
  ::
  ++  build-mast
    |=  =name
    !<  mast
    =-  -(+>+ +>.hull)
    !>  (~(got by deck) name)
  ::
  ++  take-hoot
    =|  bag=(map name sack)
    |=  mat=manx:hoot
    ^-  [manx _bag]
    =/  mar=marl:hoot  [mat ~]
    =<  ?>  ?=(^ p)  [i.p q]
    |-  ^-  (pair marl _bag)
    %^  spin  mar  bag
    |=  [i=tuna:hoot a=_bag]
    ^-  [manx _bag]
    ?>  ?=(^ -.i)
    ?.  ?=([%mast @] n.g.i)
      =/  [m=marl b=_bag]  ^$(mar c.i, bag a)
      :_  (~(uni by a) b)
      :_  m
      :-  n.g.i
      %-  mart  a.g.i
    =;  [key=(unit tape) sac=(unit sack)]
      ?>  ?=(^ key)
      :-  [[n.g.i [[%key u.key] ~]] ~]
      ?~  sac  bag
      %+  ~(put by bag)  +.n.g.i  u.sac
    %+  roll  a.g.i
    |=  $:  [k=mane:hoot v=(list beer:hoot)]
            [ke=(unit tape) sa=(unit sack)]
        ==
    ^+  [ke sa]
    ?:  ?=(%sack k)
      :-  ke
      ?>  ?&  ?=(^ v)
              ?=(^ i.v)
              ?=(%hand -.p.i.v)
              ?=(%1 -.q.p.i.v)
          ==
      :-  ~  [p.p.i.v p.q.p.i.v]
    ?:  ?=(%key k)
      :_  sa
      :-  ~
      %-  tape  v
    :-  ke  sa
  ::
  ++  get-wood   :: TODO: these are used in routing an event to a component
    |=  [tac=tack rop=rope]
    ^-  wood
    ?~  tac  p.rop
    %=  $
      tac  t.tac
      rop  (~(got by q.rop) i.tac)
    ==
  ::
  ++  put-wood
    |=  [tac=tack wod=wood rop=rope]
    ^-  rope
    ?~  tac  rop(p wod)
    %_  rop
      q
        %+  ~(put by q.rop)  i.tac
        %=  $
          tac  t.tac
          rop  (~(got by q.rop) i.tac)
        ==
    ==
  ::
  --
::
++  make
  |=  [=term key=tape limited-sack=tape]
  ^-  manx
  [[[%mast term] [[%sack limited-sack] [%key key] ~]] ~]
::
++  make-hoot
  |=  [=term key=tape =sack]
  ^-  manx:hoot
  =/  prop=hoon  [%hand [p.sack [%1 q.sack]]]
  [[[%mast term] [[%sack [[~ prop] ~]] [%key key] ~]] ~]
::
:: ++  pin
::   |*  session-state=mold
::   =>
::   |%
::   +$  event  crow
::   +$  rig  rig-0
::   +$  rig-0
::     $:  =last-heard
::         =storage
::         =aft
::     ==
::   +$  last-heard  (map ship @da)
::   +$  storage     (map ship session-state)
::   +$  aft         (map ship sail)
::   --
::   ::
::   =|  rig
::   =*  rig  -
::   ^=  mast
::   |%
::   ::
::   ++  gale
::     |=  [bowl:gall rid=@ta =sail]
::     ^-  (quip card:agent:gall ^rig)
::     =/  new  (hoist sail)
::     ?.  ?&  =(%html n.g.new)  ?=(^ c.new)
::             =(%head n.g.i.c.new)  ?=(^ t.c.new)
::             =(%body n.g.i.t.c.new)
::         ==
::       !!
::     =.  aft  (~(put by aft) src new)
::     =?  last-heard  !=(src our)
::       (~(put by last-heard) src now)
::     =.  rig  (swab now)
::     =/  =mart
::       :~  [%our +:(scow %p our)]
::           [%app (trip dap)]
::           [%sub (spud (make-sub-path src))]
::       ==
::     :_  rig
::     %^    make-direct-http-cards
::         rid
::       [200 ['Content-Type' 'text/html'] ~]
::     :-  ~
::     %-  as-octt:mimes:html
::     %-  en-xml:html
::     %_  new
::       a.g    (weld a.g.new mart)
::       c.i.c  (snoc c.i.c.new script-node)
::     ==
::   ::
::   ++  gust
::     |=  [bowl:gall =sail]
::     ^-  (quip card:agent:gall ^rig)
::     =/  new  (hoist sail)
::     =/  old  (~(got by aft) src)
::     ?.  ?&  =(%html n.g.new)  ?=(^ c.new)
::             =(%head n.g.i.c.new)  ?=(^ t.c.new)
::             =(%body n.g.i.t.c.new)
::             =(%html n.g.old)  ?=(^ c.old)
::             =(%head n.g.i.c.old)  ?=(^ t.c.old)
::             =(%body n.g.i.t.c.old)
::         ==
::       !!
::     =.  aft  (~(put by aft) src new)
::     :_  rig
::     :_  ~
::     :^    %give
::         %fact
::       [(make-sub-path src) ~]
::     :-  %json
::     !>  ^-  json
::     [%a (luff [i.t.c.old ~] [i.t.c.new ~])]
::   ::
::   ++  agent
::     |=  =agent:gall
::     ^-  agent:gall
::     |_  =bowl:gall
::     +*  this  .
::         ag    ~(. agent bowl)
::     ::
::     ++  on-init
::       ^-  (quip card:agent:gall agent:gall)
::       =^  cards  agent  on-init:ag
::       [cards this]
::     ::
::     ++  on-save   on-save:ag
::     ::
::     ++  on-load
::       |=  old-state=vase
::       ^-  (quip card:agent:gall agent:gall)
::       =^  cards  agent  (on-load:ag old-state)
::       [cards this]
::     ::
::     ++  on-poke
::       |=  [=mark =vase]
::       ^-  (quip card:agent:gall agent:gall)
::       ?.  ?=(%json mark)
::         =^(cards agent (on-poke:ag [mark vase]) [cards this])
::       =+  !<(jon=json vase)
::       ?.  ?&  ?=(%a -.jon)  ?=(^ p.jon)
::               =([%s 'mast'] i.p.jon)  ?=(^ t.p.jon)
::           ==
::         =^(cards agent (on-poke:ag [mark vase]) [cards this])
::       =/  =crow  (parse-channel-data i.t.p.jon)
::       =?  last-heard  !=(src.bowl our.bowl)
::         (~(put by last-heard) src.bowl now.bowl)
::       =^  cards  agent
::         (on-poke:ag [%mast-event !>(crow)])
::       [cards this]
::     ::
::     ++  on-watch
::       |=  =path
::       ^-  (quip card:agent:gall agent:gall)
::       ?:  ?=([%http-response *] path)
::         [~ this]
::       ?:  ?=([%mast @ta ~] path)
::         ?>  =(src.bowl (slav %p i.t.path))
::         [~ this]
::       =^  cards  agent  (on-watch:ag path)
::       [cards this]
::     ::
::     ++  on-leave
::       |=  =path
::       ^-  (quip card:agent:gall agent:gall)
::       =^  cards  agent  (on-leave:ag path)
::       [cards this]
::     ::
::     ++  on-peek   on-peek:ag
::     ::
::     ++  on-agent
::       |=  [=wire =sign:agent:gall]
::       ^-  (quip card:agent:gall agent:gall)
::       =^  cards  agent  (on-agent:ag wire sign)
::       [cards this]
::     ::
::     ++  on-arvo
::       |=  [=wire =sign-arvo]
::       ^-  (quip card:agent:gall agent:gall)
::       =^  cards  agent  (on-arvo:ag wire sign-arvo)
::       [cards this]
::     ::
::     ++  on-fail
::       |=  [=term =tang]
::       ^-  (quip card:agent:gall agent:gall)
::       =^  cards  agent  (on-fail:ag term tang)
::       [cards this]
::     ::
::     --
::   ::
::   ++  swab
::     |=  now=@da
::     ^-  ^rig
::     =/  threshold  ~d1
::     =^  dead=(set @p)  last-heard
::       %-  %~  rep  by  last-heard
::       |=  [i=(pair @p @da) a=(pair (set @p) ^last-heard)]
::       ?:  (lth (sub now q.i) threshold)
::         %_(a q (~(put by q.a) i))
::       %_(a p (~(put in p.a) p.i))
::     %_  rig
::       storage  (malt (skip ~(tap by storage) |=([p=@p *] (~(has in dead) p))))
::       aft      (malt (skip ~(tap by aft) |=([p=@p *] (~(has in dead) p))))
::     ==
::   ::
::   --
::
++  bind-url
  |=  [app=@tas url=path]
  ^-  card:agent:gall
  [%pass /bind %arvo %e %connect [~ url] app]
::
++  make-css-response
  |=  [rid=@ta css=@t]
  ^-  (list card:agent:gall)
  %^  make-direct-http-cards  rid 
    [200 ['Content-Type' 'text/css'] ~]
  [~ (as-octs:mimes:html css)]
::
++  make-auth-redirect
  |=  rid=@ta
  ^-  (list card:agent:gall)
  %^  make-direct-http-cards  rid
  [307 ['Location' '/~/login?redirect='] ~]  ~
::
++  make-400
  |=  rid=@ta
  ^-  (list card:agent:gall)
  %^  make-direct-http-cards
  rid  [400 ~]  ~
::
++  make-404
  |=  [rid=@ta data=(unit octs)]
  ^-  (list card:agent:gall)
  %^  make-direct-http-cards
  rid  [404 ~]  data
::
++  make-direct-http-cards
  |=  [rid=@ta head=response-header.simple-payload:http data=(unit octs)]
  ^-  (list card:agent:gall)
  :~  [%give %fact ~[/http-response/[rid]] [%http-response-header !>(head)]]
      [%give %fact ~[/http-response/[rid]] [%http-response-data !>(data)]]
      [%give %kick ~[/http-response/[rid]] ~]
  ==
::
++  make-sub-path
  |=  src=@p
  ^-  path
  [%mast (scot %p src) ~]
::
++  script-node
  ^-  manx
  ;script: {(trip mast-js)}
::
++  parse-channel-data
  |=  jon=json
  ^-  crow
  :: TODO: handle all event types
  :-  %poke
  ((ot ~[path+pa data+(om so)]):dejs:format jon)
::
++  hoist
  |_  sail=manx
  ++  $
    ^-  manx
    ?.  ?&  =(%html n.g.sail)  ?=(^ c.sail)
            =(%head n.g.i.c.sail)  ?=(^ t.c.sail)
            =(%body n.g.i.t.c.sail)
        ==
      ~|  'document must be structured as: <html><head></head><body></body></html>'
      !!
    %_  sail
      i.t.c  (anx i.t.c.sail ["" ~])
    ==
  ++  anx
    |=  [m=manx key=(pair tape (list @))]
    ^-  manx
    =/  fkey=@t  (getv %key a.g.m)
    =/  nkey=(pair tape (list @))
      ?~(fkey key [((w-co:co 1) `@uw`(mug fkey)) ~])
    =/  ntap=tape
      ?~  q.nkey  p.nkey
      (weld p.nkey ((w-co:co 1) `@uw`(jam q.nkey)))
    ?:  =(%$ n.g.m)
      ;t-
        =key  ntap
        ;+  m
      ==
    %_    m
        a.g
      ^-  mart  
      ?~  fkey
        [[%key ntap] a.g.m]
      a.g.m
        c
      ?:  ?|  =(%input n.g.m)  =(%textarea n.g.m)
              =(%script n.g.m)  =(%img n.g.m)
              =(%link n.g.m)  =(%hr n.g.m)
              =(%meta n.g.m)  =(%base n.g.m)
          ==
        c.m
      (arl c.m nkey)
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
    :_  acc
    ^-  json
    :-  %o
    %-  my
    :~  ['p' [%s 'd']]
        ['q' [%a (turn old |=(m=manx [%s (getv %key a.g.m)]))]]
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
      acc
        %+  snoc  acc
        ^-  json
        :-  %o
        %-  my
        :~  ['p' [%s 'm']]
            ['q' [%s (getv %key a.g.i.new)]]
            ['r' [%n (getv %i a.g.i.new)]]
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
        %+  snoc  acc
        ^-  json
        :-  %o
        %-  my
        :~  ['p' [%s 'n']]
            ['q' [%s pkey]]
            ['r' [%n (scot %ud i)]]
            ['s' [%s (crip (en-xml:html i.new))]]
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
        =/  aupd  (upda a.g.i.old a.g.i.nnew)
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
              acc
                ?:  &(?=(~ del.aupd) ?=(~ new.aupd))
                  acc
                :_  acc
                ^-  json
                :-  %o
                %-  my
                :~  ['p' [%s 'c']]
                    ['q' [%s k.nnky]]
                    ['r' [%a del.aupd]]
                    ['s' [%a new.aupd]]
                ==
            ==
        ==
      =/  aupd  (upda a.g.i.jold a.g.i.new)
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
            acc
              =.  acc
                %+  snoc  acc
                ^-  json
                :-  %o
                %-  my
                :~  ['p' [%s 'm']]
                    ['q' [%s k.nkey]]
                    ['r' [%n (scot %ud i)]]
                ==
              ?:  &(?=(~ del.aupd) ?=(~ new.aupd))
                acc
              :_  acc
              ^-  json
              :-  %o
              %-  my
              :~  ['p' [%s 'c']]
                  ['q' [%s k.nkey]]
                  ['r' [%a del.aupd]]
                  ['s' [%a new.aupd]]
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
        ?.  &(?=(^ c.i.new) ?=(^ a.g.i.c.i.new))
          ''
        (crip v.i.a.g.i.c.i.new)
      %=  ^$
        old  t.old
        new  t.new
        i    +(i)
        acc
          :_  acc
          ^-  json
          :-  %o
          %-  my
          :~  ['p' [%s 't']]
              ['q' [%s (getv %key a.g.i.new)]]
              ['r' [%s txt]]
          ==
      ==
    =/  aupd  (upda a.g.i.old a.g.i.new)
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
          acc
            ?:  &(?=(~ del.aupd) ?=(~ new.aupd))
              acc
            :_  acc
            ^-  json
            :-  %o
            %-  my
            :~  ['p' [%s 'c']]
                ['q' [%s k.nkey]]
                ['r' [%a del.aupd]]
                ['s' [%a new.aupd]]
            ==
        ==
    ==
  %=  $
    jold  t.jold
    j     +(j)
  ==
::
++  getv
  |=  [t=@tas m=mart]
  ^-  @t
  ?~  m  ''
  ?:  =(n.i.m t)
    (crip v.i.m)
  $(m t.m)
::
++  upda
  |=  [om=mart nm=mart]
  =|  acc=[del=(list json) new=(list json)]
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
--
