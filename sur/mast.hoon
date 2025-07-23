|%
+$  crow  [=path data=(map @t @t)]               :: event for a component
+$  blow  (list cage)                            :: pokes for an agent from a component
+$  hull                                         :: component sample
  $:  our=ship                                   ::
      src=ship                                   ::
    ::                                           ::
      bas=knot                                   ::   base url segment bound to
      rut=path                                   ::   rest of the url path
      que=quay                                   ::   query params
    ::                                           ::
      now=time                                   ::
      eny=@uvJ                                   ::
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
+$  bind  (pair knot line)                       :: base url segment to root component
+$  dock  (map knot line)                        :: bindings
+$  deck  (map hook mast)                        :: component cache
+$  hook  term                                   :: component name
+$  rode  cord                                   :: component key
+$  rope                                         :: url
  $:  bas=knot                                   ::   base segment
      rut=path                                   ::   rest of path
      que=quay                                   ::   query params
  ==                                             ::
+$  line                                         :: component reference and inputs
  $:  com=hook                                   ::
      par=gust                                   ::
      res=pool                                   ::
  ==                                             ::
+$  pool  (map @tas path)                        :: resources for a component
+$  buoy  [?(%add %del) p=rode q=path]           :: resource subscription effect
+$  wake                                         :: component creation effect
  $:  bos=(set buoy)                             ::
      new=isle                                   ::
  ==                                             ::
+$  cove                                         :: component state
  $:  dif=atom                                   ::
      bom=boom                                   ::
      aft=manx                                   ::
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
      :-  [%hook component]  ~
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

