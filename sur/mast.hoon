|%
+$  crow  [=path data=(map @t @t)]               :: event for a component
+$  blow  (list cage)                            :: pokes for an agent from a component
+$  gull                                         :: mast actions
  $%  [%navigate src=ship ses=buoy to=rope]      ::
  ==                                             ::
+$  hull                                         :: component sample
  $:  our=ship                                   ::   our
      src=ship                                   ::   src
      ses=buoy                                   ::   session id
    ::                                           ::
      bas=knot                                   ::   base url segment bound to
      rut=path                                   ::   rest of the url path
      que=quay                                   ::   query params
    ::                                           ::
      now=time                                   ::   time
      eny=@uvJ                                   ::   entropy
    ::                                           ::
      par=gust                                   ::   component params
      res=gale                                   ::   resources
  ==                                             ::
+$  quay  (map @t @t)                            :: query params
+$  gust  (map @tas @t)                          :: component params
+$  gale                                         :: component resources
  %+  map  @tas                                  ::
  $:  src=path                                   ::
      fil=page                                   ::
      dir=(list path)                            ::
  ==                                             ::
:: +$  boom                                         :: resource spec
::   %-  list                                       ::
::   $:  name=@tas                                  ::   map key
::       mark=@tas                                  ::   mark, possibly converted to
::   ==                                             ::
+$  mast                                         :: component
  $_  ^|                                         ::
  |_  hull                                       ::
  ++  spar  *$-(crow blow)                       ::
  ++  sail  *manx                                ::
  --                                             ::
+$  buoy  @                                      :: session id
+$  bind  (pair knot line)                       :: base url segment to root component
::+$  dock  (map knot line)                        :: bindings
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
+$  tide  [?(%add %del) p=(list rode) q=path]    :: resource subscription effect
+$  wake  (list tide)                            ::
+$  navy                                         ::
  %+  map  path                                  ::
  %-  set  (pair [ship buoy] (list rode))        ::
+$  gulf  (map [ship buoy] (pair rope isle))     ::
+$  isle                                         ::
  $~  [*line ~]                                  ::
  %+  pair  line  (map rode isle)                ::
+$  mess  (list grog)                            ::
+$  grog                                         ::
  %+  pair  path                                 ::
  $%  [%put =page]                               ::
      [%tom =case]                               ::
      [%cul =case]                               ::
    ==                                           ::
+$  swab  @da                                    ::
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
--

