|%
+$  gull                                         :: poke, component --> agent
  $:  src=ship                                   ::   client id
      com=hook                                   ::   component
      dat=cage                                   ::   poke data
  ==                                             ::
+$  crow  [=path data=(map @t @t)]               :: event poke, client --> component
+$  blow  (list (pair @tas cage))                :: pokes emitted from a component
+$  quay                                         :: url + query params
  $:  url=path                                   ::
      wut=(map @t @t)                            ::
  ==                                             ::
+$  keel                                         :: root component sample     :: TODO: add the desk of the router gate?
  $:  our=ship                                   ::   our
      bas=knot                                   ::   base path segment bound to
      quay                                       ::   request url + query params
  ==                                             ::
+$  hull                                         :: component sample
  $:  our=ship                                   ::   our
      src=navy                                   ::   src, null unless mode is %auth
      par=gust                                   ::   params
      res=gale                                   ::   resources
  ==                                             ::
+$  navy  (unit ship)                            :: component src ship
+$  gust  (map @tas @t)                          :: component params
+$  gale                                         :: component resources
  %+  map  @tas                                  ::
  $:  src=path                                   ::
      fil=vase                                   ::
  ==                                             ::
+$  mode  ?(~ %auth)                             :: component mode
+$  boom                                         :: resource spec
  %-  list                                       ::
  $:  name=@tas                                  ::
      mark=@tas                                  ::
  ==                                             ::
+$  mast                                         :: component core
  $:  $:  =mode                                  ::
          =boom                                  ::
      ==                                         ::
      $_  ^|                                     ::
      |_  hull                                   ::
      ++  spar  *$-(crow blow)                   ::
      ++  sail  *manx                            ::
      --                                         ::
  ==                                             ::
+$  mist                                         :: router gate
  $-  keel                                       ::   the root of an interface,
  $_                                             ::   bound to a base url segment,
  ;html                                          ::   the router gate defines a
    ;+  :*  [%head ~]                            ::   function of route+params
            hed=*marl                            ::   to a document which nests
        ==                                       ::   an initial mast component
    ;+  :~  [%body *mart]                        ::
            ^=  com                              ::
            [[[%mast *@tas] *mart] *marl]        ::
        ==                                       ::
  ==                                             ::
+$  hook  [=desk name=@tas]                      :: component desk and file name
+$  bind  [=knot hook]                           :: bind base path name to root component
::
  ::
::
+$  lake                                         :: component cache
  %+  map  hook                                  ::
  $%  [%mast p=mast]                             ::
      [%mist p=mist]                             ::
  ==                                             ::
+$  dock  (map knot hook)                        :: base path to router bindings
:: +$  dock  (map knot (pair hook deck))            :: base path to component state
:: +$  deck  (map rope bitt)                        :: component state map
:: +$  rope  (pair rode navy)                       :: component key
:: +$  rode  @                                      ::
+$  line                                         :: component essential state
  $:  com=hook                                   ::
      par=gust                                   ::
      res=tide                                   ::
  ==                                             ::
:: +$  bitt                                         :: component state
::   $:  mod=mode                                   ::   mode
::       bom=boom                                   ::   boom
::       src=navy                                   ::   src, null unless auth
::       pas=(set rope)                             ::   all current parents
::       aft=manx                                   ::   most recent render
::       line                                       ::
::   ==                                             ::
:: +$  tide  (map @tas path)                        :: resources for a component
:: +$  pool  (map rode line)                        :: nested component element data
:: +$  buoy  [?(%add %del) p=rope q=path]           :: subscription effect
:: +$  wake                                         :: component creation effects
::   $:  bos=(set buoy)                             ::
::       dek=deck                                   ::
::   ==                                             ::
::
  ::
::
+$  scud
  $~  ~
  %-  list
  $@  ?(%skip)
  $:  tag=@t
      key=@t
      hax=@t
      kid=scud
  ==
::
  ::
::
+$  diff  (list json)                            :: ++luff diff output
+$  jiff
  $%  [%new parent-key=_s+'' index=_n+'' data=_s+'']
      [%delete keys=[%a (list _s+'')]]
      [%move key=_s+'' index=_n+'']
      :: [%change-attr key=_s+'' del=[%a (list k=_s+'')] new=[%a (list [%a k=_s+'' v=_s+'' ~])]]
      [%attr key=_s+'' new=[%a (list [%a k=_s+'' v=_s+'' ~])]]
      [%text container-key=_s+'' data=_s+'']
  ==
::
  ::
::
:: ++make
:: produce a %mast component element.
++  make
  |=  $:  component=hook
          params=(list [@tas cord])
          resources=(list [@tas path])
      ==
  ^-  manx
  :_  ~
  :*  :-  %mast  (spat [desk.component name.component ~])
      %+  weld
      ^-  mart
      %+  turn  params
      |=  [k=@tas v=cord]
      :-  [%gust k]  (trip v)
      ^-  mart
      %+  turn  resources
      |=  [k=@tas v=path]
      :-  [%gale k]  (spud v)
  ==
::
:: ++make-client-state
:: produce an element that adds values
:: to the client state object on render
++  make-client-state
  |=  kv-list=(list (pair term tape))
  ^-  manx
  :_  ~
  :*  :-  %client  %state
      :-  %style  "display:none"
      kv-list
  ==
::
--

