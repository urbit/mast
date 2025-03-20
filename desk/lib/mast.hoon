/*  mast-js  %js  /lib/mast/js
|%
::
+$  url  path                                    ::
+$  crow                                         :: client events
  $%  [%poke =path data=(map @t @t)]             ::
      [%open req=inbound-request:eyre]           ::
  ==                                             ::
+$  blow                                         :: event effects
  $:  p=(unit url)                               ::   change session route state
      q=(unit cage)                              ::   forward a poke to the agent
  ==                                             ::
+$  name  term                                   :: component name
+$  dock  (list [name mast])                     :: component list
+$  deck  (map name mast)                        :: component map
+$  hull  agent:gall                             :: nested agent
+$  bowl  bowl:gall                              :: bowl
+$  stay  [=url =bowl]                           :: component context
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
  $:  =url                                       ::
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
+$  loot  (map clew sack)                        :: props for rendered components
+$  buoy  (set name)                             :: reactive component record
+$  brig                                         :: %mast internal state
  $:  =buoy
      =rigs
  ==
::
+$  card  card:agent:gall
+$  diff
  %+  pair  [del=(set clew) add=(map clew rope)]
  %-  list  json
+$  jiff
  $%  [%new parent-key=_s+'' index=_n+'' data=_s+'']
      [%delete keys=[%a (list _s+'')]]
      [%move key=_s+'' index=_n+'']
      [%change-attr key=_s+'' del=[%a (list k=_s+'')] new=[%a (list [%a k=_s+'' v=_s+'' ~])]]
      [%text container-key=_s+'' data=_s+'']
  ==
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
++  bind-url
  |=  [app=@tas =url]
  ^-  card:agent:gall
  [%pass /bind %arvo %e %connect [~ url] app]
::
++  make-auth-redirect
  |=  rid=@ta
  ^-  (list card:agent:gall)
  %^  make-direct-http-cards  rid
  [307 ['Location' '/~/login?redirect='] ~]  ~
::
++  make-direct-http-cards
  |=  [rid=@ta hed=response-header.simple-payload:http dat=(unit octs)]
  ^-  (list card:agent:gall)
  :~  [%give %fact ~[/http-response/[rid]] [%http-response-header !>(hed)]]
      [%give %fact ~[/http-response/[rid]] [%http-response-data !>(dat)]]
      [%give %kick ~[/http-response/[rid]] ~]
  ==
::
++  wrap
  |=  [=deck =hull]
  ^-  agent:gall
  =|  =brig
  =<
  =.  buoy.brig  check-masts
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
      =^  diffs  brig  (gust bowl)
      :_  this
      %+  weld  cards  diffs
      ::
        %handle-http-request
      =+  !<([rid=@ta req=inbound-request:eyre] vase)
      ?+  method.request.req
        ::
        :: TODO: make handle-http-request fall through to hull
        ~|(bad-method/method.request.req !!)
        ::
          %'GET'
        =^  cards  brig  (gale rid req bowl)
        :-  cards  this
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
        =^  cards  hull  (on-poke:hu [mark vase])
        =^  diffs  brig  (gust bowl)
        :_  this
        %+  weld  cards  diffs
      =/  [tac=tack cro=crow]  (parse-channel-data i.t.p.jon)
      =^  [new-url=? new-poke=(unit cage) new-local=(unit tack)]  brig
        %^  sway  tac  cro  bowl
      ?:  ?&  !new-url
              ?=(~ new-poke)
              ?=(~ new-local)
          ==
        :-  ~  this
      =^  cards  hull
        ?^  new-poke  (on-poke:hu u.new-poke)
        :-  *(list card)  hull
      =^  diffs  brig  (gust bowl)          :: TODO: add new-local
      :_  this
      %+  weld  cards  diffs
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
    =^  diffs  brig  (gust bowl)
    :_  this
    %+  weld  cards  diffs
  ::
  ++  on-leave
    |=  =path
    ^-  (quip card _this)
    =^  cards  hull  (on-leave:hu path)
    =^  diffs  brig  (gust bowl)
    :_  this
    %+  weld  cards  diffs
  ::
  ++  on-peek   on-peek:hu
  ::
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    ^-  (quip card _this)
    =^  cards  hull  (on-agent:hu wire sign)
    =^  diffs  brig  (gust bowl)
    :_  this
    %+  weld  cards  diffs
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    =^  cards  hull  (on-arvo:hu wire sign-arvo)
    =^  diffs  brig  (gust bowl)
    :_  this
    %+  weld  cards  diffs
  ::
  ++  on-fail
    |=  [=term =tang]
    ^-  (quip card _this)
    =^  cards  hull  (on-fail:hu term tang)
    =^  diffs  brig  (gust bowl)
    :_  this
    %+  weld  cards  diffs
  ::
  --
  ::
  |%
  ::
  ++  gale
    |=  [rid=@ta req=inbound-request:eyre =bowl]
    ^-  (quip card ^brig)
    =/  url  (stab url.request.req)  :: TODO: need better url parsing
    =/  say  `stay`[url bowl]
    =/  eve  `crow`[%open req]
    =/  ses  (~(get by rigs.brig) src.bowl)
    :: TODO:
    :: ?^  ses
    ::   :: if the session already exists, update url state and send an open event, then process it as a regular event update.
    ::   =.  url.u.ses  url
    ::   =/  arg=[stay sack stow]  [[url.u.ses bowl] !>(~) sow.p.rope.u.ses]
    ::   =/  [bow=blow sow=stow]   (~(spar (build-mast %$) arg) eve)
    ::   =/  same-local-state=?    =(sow sow.p.rope.u.ses)
    ::   =.  sow.p.rope.u.ses      sow
    ::   =/  same-url=?            |(?=(~ url.bow) =(u.p.bow url.u.ses))
    ::   =?  url.u.ses             ?=(^ url.bow)  u.p.bow
    ::   ?^  q.bow
    ::     :: forward poke to agent if q.bow
    ::     
    ::   ?:  &(same-url same-local-state)
    ::     :: no change
    ::     :-  ~
    ::     %_  brig
    ::       rigs  (~(put by rigs.brig) src.bowl u.ses)
    ::     ==
    ::   :: do reactive render check

    :: else create the session and render out the component tree with a branch add case for the root.
    :: TEST:
    =/  rop  (branch-create *clew !>(~) say)
    =/  sal  (branch-manx-assemble rop)
    :_  %_  brig
          rigs  (~(put by rigs.brig) src.bowl [url rop])
        ==
    =/  mar
      ^-  mart
      :~  [%our +:(scow %p our.bowl)]
          [%app (trip dap.bowl)]
          [%sub (spud (make-sub-path src.bowl))]
      ==
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
  ++  gust
    |=  =bowl
    ^-  (quip card ^brig)
    =^  cards=(list card)  rigs.brig
      %+  ~(rib by rigs.brig)  *(list card)
      |=  $:  [src=ship ses=[=url rop=rope]]
              acc=(list card)
          ==
      =.  src.bowl  src
      =/  say=stay  [url.ses bowl]
      =^  jon=(list json)  rop.ses
        %:  diff-component-tree
          say  ~  *clew  rop.ses
        ==
      :_  [src ses]
      :_  acc
      ^-  card
      :^    %give
          %fact
        [(make-sub-path src) ~]
      :-  %json
      !>  `json`[%a jon]
    :-  cards  brig
  ::
  :: apply an event to a component;
  :: produce a possible route change,
  :: a possible poke to forward to the agent,
  :: and a possible route to a component with a local state change.
  ++  sway
    |=  [tac=tack cro=crow bol=bowl]
    ^-  [[new-url=? (unit cage) (unit tack)] ^brig]
    =/  ses  (~(got by rigs.brig) src.bol)
    =/  say  `stay`[url.ses bol]
    =/  wod  (get-wood tac rope.ses)
    =/  com  (build-mast name:(rear tac))
    =/  [bow=blow sow=stow]
      %-  ~(spar com [say sac.wod sow.wod])  cro
    :-  :*  &(?=(^ p.bow) !=(u.p.bow url.ses))
            q.bow
            ?:(=(sow sow.wod) ~ [~ tac])
        ==
    %_  brig
      rigs
        %+  ~(put by rigs.brig)  src.bol
        %_  ses
          url  ?^(p.bow u.p.bow url.ses)
          rope
            %^  put-wood  tac  wod(sow sow)  rope.ses
        ==
    ==
  ::
  :: parse json from the client into a component route and event.
  ++  parse-channel-data
    |=  jon=json
    ^-  [tack crow]
    =,  dejs:format
    =/  pok
      ^-  [route=tack =path data=(map @t @t)]
      %.  jon
      %-  ot
      :~  route+(ar (ot ~[name+so key+so]))
          path+pa
          data+(om so)
      ==
    :-  route.pok
    :-  %poke  [path.pok data.pok]
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
  ++  build-mast
    |=  =name
    !<  mast
    =-  -(+>+ +>.hull)
    !>  (~(got by deck) name)
  ::
  ++  check-masts
    ^-  buoy
    =;  [acc=buoy err=buoy]
      ?:  .=  ~  err  acc
      ~&  >>>  "%mast wrap error:"
      ?:  .=  ~(wyt in err)  ~(wyt in ~(key by deck))
        ~&  >>>  "The context of the agent does not match the context of its components."
      !!
      ~&  >>>  'The context of the following components do not match the context of their agent:'
      ~&  >>>  ~(tap in err)
      !!
    %-  %~  rep  by  deck
    |=  [[k=name v=mast] acc=buoy err=buoy]
    =/  com=(unit mast)  (mole |.((build-mast k)))
    :-  =/  sud  ?~(com ~ scud:u.com)
        ?^  sud  (~(put in acc) k)  acc
    ?:  ?&  ?=(^ com)
            =(+>.v +>.u.com)  :: TODO: should be comparing context types instead of noun equality
        ==
      err
    %-  ~(put in err)  k
  ::
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
    =;  [key=(unit tape) sac=(unit sack)]
      ?~  key  ~&  >>>  "Error: mast element {<+.n.g.i>} is missing a key"  !!
      :-  [[n.g.i [[%key u.key] ~]] ~]
      %+  ~(put by a)  [+.n.g.i (crip u.key)]
      ?^  sac  u.sac  !>(~)
    %+  roll  a.g.i
    |=  $:  [k=mane:hoot v=(list beer:hoot)]
            [ke=(unit tape) sa=(unit sack)]
        ==
    ^+  [ke sa]
    ?:  ?=(%sack k)
      :-  ke
      ?.  ?&  ?=(^ v)
              ?=(^ i.v)
              ?=(%hand -.p.i.v)
              ?=(%1 -.q.p.i.v)
          ==
        :-  ~  !>(;;(tape v))
      :-  ~  [p.p.i.v p.q.p.i.v]
    ?:  ?=(%key k)
      :_  sa
      :-  ~
      %-  tape  v
    :-  ke  sa
  ::
  ++  get-loot
    =|  lot=loot
    |=  man=manx
    ^-  loot
    =?  lot  ?=([%mast @] n.g.man)
      =;  [key=(unit tape) sac=(unit sack)]
        ?~  key  ~&  >>>  "Error: mast element {<+.n.g.man>} is missing a key"  !!
        %+  ~(put by lot)  [+.n.g.man (crip u.key)]
        ?^  sac  u.sac  !>(~)
      %+  roll  a.g.man
      |=  $:  [k=mane v=tape]
              [ke=(unit tape) sa=(unit sack)]
          ==
      ?:  ?=(%sack k)
        :-  ke  [~ !>(v)]
      ?:  ?=(%key k)
        :-  [~ v]  sa
      :-  ke  sa
    %+  roll  c.man
    |=  [i=manx a=_lot]
    %=  ^$
      man  i
      lot  a
    ==
  ::
  ++  get-wood
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
  ++  branch-create
    |=  [cew=clew sac=sack say=stay]
    ^-  rope
    =/  com  (build-mast name.cew)
    =/  sow  ;;(stow +<+<.com)  :: get stow for possible init bunt
    =.  +<.com  [say sac sow]
    =/  sud
      ^-  @
      ?.  (~(has in buoy.brig) name.cew)  ~
      =/  s  scud:com
      ?~  s  ~
      %-  mug  u.s
    =/  [sal=manx lot=loot]
      =/  man  sail:com
      ?.  ?=(%hoot -.man)
        :-  man  (get-loot man)
      %-  take-hoot  +.man
    =.  sal  (haul cew sal) 
    =|  wod=wood
    :-  %_  wod
          sud  sud
          sac  sac
          sow  sow
          aft  sal
        ==
    %-  ~(urn by lot)
    |=  [k=clew v=sack]
    %=  ^$
      cew  k
      sac  v
    ==
  ::
  ++  branch-manx-assemble
    |=  rop=rope
    ^-  manx
    =/  mar=marl  [aft.p.rop ~]
    =<  ?>  ?=(^ -)  i
    |-  ^-  marl
    %+  turn  mar
    |=  i=manx
    ^-  manx
    ?.  ?=([%mast @] n.g.i)
      %_  i
        c  ^$(mar c.i)
      ==
    =/  key  (getv %key a.g.i)
    %=  ^^$
      rop  (~(got by q.rop) [+.n.g.i key])
    ==
  ::
  ++  diff-component-tree
    |=  [say=stay suc=(unit sack) cew=clew rop=rope]
    ^-  (quip json rope)
    =/  react=?  (~(has in buoy.brig) name.cew)
    =/  props=?  &(?=(^ suc) !=(u.suc sac.p.rop))
    =^  upd=$@(~ [=diff =loot])  p.rop
      ?.  |(react props)
        :-  ~  p.rop
      =/  com
        =-  -(+< [say ?^(suc u.suc sac.p.rop) sow.p.rop])
        %-  build-mast  name.cew
      =/  sud
        ^-  @
        ?.  react  ~
        =-  ?~  -  ~  (mug u)
        =<  scud  com
      =/  render=?
        ?|  props
            !=(sud sud.p.rop)
        ==
      =:  sud.p.rop  sud
          sac.p.rop  ?^(suc u.suc sac.p.rop)
        ==
      ?.  render
        :-  ~  p.rop
      =/  [sal=manx lot=loot]
        =/  man  sail:com
        ?.  ?=(%hoot -.man)
          :-  man  (get-loot man)
        %-  take-hoot  +.man
      =.  sal  (haul cew sal)
      :-  [(luff say lot [aft.p.rop ~] [sal ~]) lot]
      %_  p.rop
        aft  sal
      ==
    =^  acc=(list json)  q.rop
      %-  ~(rep by q.rop)
      |=  [[k=clew v=rope] a=(pair (list json) (map clew rope))]
      ?:  ?&  ?=(^ upd)
              (~(has in del.p.diff.upd) k)
          ==
        a
      =^  b=(list json)  v
        %=  ^$
          cew  k
          rop  v
          suc  ?^(upd (~(get by loot.upd) k) ~)
        ==
      %_  a
        p  (weld p.a b)
        q  (~(put by q.a) k v)
      ==
    ?~  upd  [acc rop]
    :-  (weld q.diff.upd acc)
    %_  rop
      q  (~(uni by q.rop) add.p.diff.upd)
    ==
  ::
  ++  haul
    |_  [cew=clew man=manx]
    ++  $
      ^-  manx
      =/  component-attr  [%component (trip name.cew)]
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
      %+  anx  man  [(trip key.cew) ~]
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
  ++  luff
    |=  [say=stay lot=loot old=marl new=marl]
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
      =/  dels=(list [n=mane k=@t])  (turn old |=(m=manx [n.g.m (getv %key a.g.m)]))
      %_  acc
        del.p
          %-  ~(gas in del.p.acc)
          %+  roll  dels
          |=  [[n=mane k=@t] a=(list clew)]
          ?.  ?=([%mast @] n)  a
          :-  [+.n k]  a
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
          =/  cew  `clew`[+.n.g.i.new k.nkey]
          =/  suc  (~(get by lot) cew)
          =/  rop  (branch-create cew ?~(suc !>(~) u.suc) say)
          %_  acc
            add.p  (~(put by add.p.acc) cew rop)
            q
              %+  snoc  q.acc
              %-  swig
              :*  %new
                  [%s pkey]
                  [%n (scot %ud i)]
                  [%s (crip (en-xml:html (branch-manx-assemble rop)))]
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
  ++  getv
    |=  [t=@tas m=mart]
    ^-  @t
    ?~  m  ''
    ?:  =(n.i.m t)
      (crip v.i.m)
    $(m t.m)
  ::
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

