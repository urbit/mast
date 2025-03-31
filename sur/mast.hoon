|%
+$  crow                                         :: client events
  $%  [%poke =path data=(map @t @t)]             ::
      [%open req=inbound-request:eyre]           ::
  ==                                             ::
+$  blow  (quip card loc=$@(~ vase))             :: event effects
+$  prop  (map @tas vase)                        :: component props state
+$  kids  (list path)                            :: child component paths :: TODO:
+$  scud                                         :: component context
  $:  our=ship                                   ::   server
      yon=ship                                   ::   client
      pax=path                                   ::   namespace node identity
      kid=kids                                   ::   child node paths
  ==                                             ::
+$  sack                                         :: component state
  $:  pop=prop                                   ::   props state
      loc=vase                                   ::   local state
      fil=vase                                   ::   node state
  ==                                             ::
+$  boom                                         :: component header
  :: $@  mark
  $:  mar=mark
      kid=?(%x %y %z)  :: TODO:
      loc=vase
  ==
+$  mast                                         :: component core
  $_  ^|                                         ::
  |_  [scud sack]                                ::
  ++  spar  *$-(crow blow)                       ::
  ++  sail  *$^([%hoot manx:hoot] manx)          ::
  --                                             ::
+$  line  (pair term path)                       :: component name + file node path
+$  rope  (lest line)                            :: component locational id
+$  buoy  [?(%add %del) p=rope]                  :: subscription effect
+$  lake  (list buoy)                            :: subscription effects
+$  dock  (map [ship line] deck)                 :: ui sessions
+$  deck                                         :: component node tree
  $~  [*clew ~]                                  ::
  %+  pair  clew                                 ::
  %+  map  line  deck                            ::
+$  clew                                         :: component node state
  $:  pop=prop                                   ::
      loc=vase                                   ::
      bom=boom                                   ::
      aft=manx                                   ::
  ==                                             ::
+$  loot  (map line sack)                        :: props for components to render


:: +$  diff
::   %+  pair  [del=(set clew) add=(map clew rope)]
::   %-  list  json
:: +$  jiff
::   $%  [%new parent-key=_s+'' index=_n+'' data=_s+'']
::       [%delete keys=[%a (list _s+'')]]
::       [%move key=_s+'' index=_n+'']
::       [%change-attr key=_s+'' del=[%a (list k=_s+'')] new=[%a (list [%a k=_s+'' v=_s+'' ~])]]
::       [%text container-key=_s+'' data=_s+'']
::   ==
--

