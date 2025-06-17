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
      url=path                                   ::
      que=quay                                   ::
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
+$  line                                         :: component reference and inputs
  $:  com=hook                                   ::
      par=gust                                   ::
      res=rode                                   ::
  ==                                             ::
+$  rode  (map @tas path)                        :: resources for a component
+$  buoy  [?(%add %del) p=path]                  :: resource subscription effect
+$  navy  (map path (set (pair ship cord)))      :: resource paths to subscribed components
+$  scud
  $~  ~
  %-  list
  $@  ?(%skip)
  $:  tag=@t
      key=@t
      hax=@t
      kid=scud
  ==
+$  isle
  $:  url=path
      que=quay
      lin=line
      sud=scud
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

