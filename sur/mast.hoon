|%
+$  gull                                         :: poke, component --> agent
  $:  src=ship                                   ::   client id
      com=hook                                   ::   component
      dat=cage                                   ::   poke data
  ==                                             ::
+$  crow  [=path data=(map @t @t)]               :: event poke, client --> component
+$  blow  (list (pair @tas cage))                :: pokes emitted from a component
+$  hull                                         :: component sample
  $:  our=ship                                   ::
      src=ship                                   ::
    ::                                           ::
      now=time                                   ::
      eny=@uvJ                                   ::
    ::                                           ::
      bas=knot                                   ::   base url segment bound to
      rut=path                                   ::   rest of the url path
      que=quay                                   ::   query params
    ::                                           ::
      par=gust                                   ::
      res=gale                                   ::
  ==                                             ::
+$  quay  (map @t @t)                            :: query params
+$  gust  (map @tas @t)                          :: component params
+$  gale                                         :: component resources
  %+  map  @tas                                  ::
  $:  src=path                                   ::
      fil=vase                                   ::
  ==                                             ::
+$  boom                                         :: resource spec
  %-  list                                       ::
  $:  name=@tas                                  ::   map key
      mark=@tas                                  ::   mark, possibly converted to
  ==                                             ::
+$  mast                                         :: component
  $:  $:  =boom                                  ::
      ==                                         ::
      $_  ^|                                     ::
      |_  hull                                   ::
      ++  spar  *$-(crow blow)                   ::
      ++  sail  *manx                            ::
      --                                         ::
  ==                                             ::
+$  bind  (pair knot line)                       ::
+$  dock  (map knot line)                        :: base path to root component bindings
+$  deck  (map hook mast)                        :: component cache
+$  hook  [=desk name=@tas]                      :: component desk and file name
+$  rode  @t                                     ::
+$  rope                                         ::
  $:  bas=knot                                   ::
      rut=path                                   ::
      que=quay                                   ::
  ==                                             ::
+$  line                                         :: component reference and inputs
  $:  com=hook                                   ::
      par=gust                                   ::
      res=pool                                   ::
  ==                                             ::
+$  pool  (map @tas path)                        :: resources for a component
+$  buoy  [?(%add %del) p=rode q=path]           :: resource subscription effect
+$  wake                                         ::
  $:  bos=(set buoy)                             ::
      new=isle                                   ::
  ==                                             ::
+$  cove                                         ::
  $:  bom=boom                                   ::
      aft=cord                                   ::
      lin=line                                   ::
  ==                                             ::
+$  isle  (map rode cove)                        ::
+$  gulf  (map [ship rope] isle)                 ::
+$  navy                                         :: resource to client subscription state
  %+  map  path                                  ::
  %+  map  (pair ship rope)                      ::
  %-  set  rode                                  ::
::
  ::
::
+$  diff                                         :: ++luff diff output
  %+  pair
  $:  bos=(set buoy)
      del=(set rode)
      add=isle
  ==
  %-  list  json
+$  jiff
  $%  [%new parent-key=_s+'' index=_n+'' data=_s+'']
      [%delete keys=[%a (list _s+'')]]
      [%move key=_s+'' index=_n+'']
      [%change-attr key=_s+'' del=[%a (list k=_s+'')] new=[%a (list [%a k=_s+'' v=_s+'' ~])]]
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
  :*  %mast
      :-  [%hook desk.component]  (trip name.component)
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
  :*  %client-state
      [%style "display:none"]
      kv-list
  ==
::
--

