|%
+$  gull                                         :: poke, component --> agent
  $:  src=ship                                   ::   client id
      com=path                                   ::   component
      dat=cage                                   ::   poke data
  ==                                             ::
+$  crow  [=path data=(map @t @t)]               :: event poke, client --> component
+$  blow  (list (pair @tas cage))                :: pokes emitted from a component
+$  quay                                         :: url + query params
  $:  url=path                                   ::
      wut=(map @t @t)                            ::
  ==                                             ::
+$  keel                                         :: root component sample
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
      dir=(list path)                            ::
      fil=vase                                   ::
  ==                                             ::
+$  mode  ?(~ %auth)                             :: component mode
+$  clew  (list (pair cord cord))                :: client state object init
+$  boom                                         :: resource spec
  %-  list                                       ::
  $:  name=@tas                                  ::
      mark=@tas                                  ::
  ==                                             ::
+$  mast                                         :: component core
  $:  $:  =mode                                  ::
          =boom                                  ::
          =clew                                  ::
      ==                                         ::
      $_  ^|                                     ::
      |_  hull                                   ::
      ++  spar  *$-(crow blow)                   ::
      ++  sail  *manx                            ::
      --                                         ::
  ==                                             ::
+$  mist                                         :: router gate
  $-  keel                                       ::   the root of an interface,
  $^  $_                                         ::   bound to a base url segment,
  ;html                                          ::   the router gate defines a
    ;head                                        ::   function of route+params
      ;*  *marl                                  ::   to a document which nests
    ==                                           ::   an initial mast component,
    ;+  :~  [%body *mart]                        ::   (or a custom response)
        :-  [[%mast *@tas] *mart]                ::
            *marl                                ::
        ==                                       ::
  ==                                             ::
  $%  [%custom simple-payload:http]              ::
  ==                                             ::
+$  hook  [=desk file=path]                      :: component file
+$  bind  [name=knot hook]                       :: bind base path name to root component
::
  ::
::
+$  dock  (map knot (pair hook deck))            :: base path to component state
+$  deck  (map rope bitt)                        :: component state map
+$  rope  (pair @uw navy)                        :: component key
+$  line                                         :: component essential state
  $:  com=hook                                   ::
      par=gust                                   ::
      res=tide                                   ::
  ==                                             ::
+$  bitt                                         :: component state
  $:  src=navy                                   ::
      mod=mode                                   ::
      par=(set rope)                             ::
      kid=(map rope)                             ::
      bom=boom                                   ::
      aft=manx                                   ::
      line                                       ::
  ==                                             ::
+$  tide  (map @tas path)                        :: resources for a component
+$  pool  (set [key=@uw line])                   :: nested component element data

:: +$  buoy  [?(%add %del) p=rope]                  :: subscription effect
:: +$  sunk                                         :: component creation error
::   $%  [%missing-component desk=@tas file=@tas]   ::
::       [%missing-resource =path]                  ::
::       [%no-tube fil=path for=mark]               ::
::   ==                                             ::

:: :: :: :: :: :: :: :: :: :: ::

+$  wake                                         :: ui effects
  $:  sun=(list sunk)                            ::
      boy=(list buoy)                            ::
      jon=(list json)                            ::
  ==                                             ::
+$  wood                                         :: component creation result
  $:  sun=(list sunk)                            ::
      boy=(list buoy)                            ::
      dek=$@(~ deck)                             ::
  ==                                             ::

:: :: :: :: :: :: :: :: :: :: ::


+$  diff                                         :: ++luff diff output
  %+  pair                                       ::
    $:  boy=(list buoy)                          ::
        del=(set line)                           ::
        add=(map line deck)                      ::
    ==                                           ::
  %-  list  json                                 ::
+$  jiff
  $%  [%new parent-key=_s+'' index=_n+'' data=_s+'']
      [%delete keys=[%a (list _s+'')]]
      [%move key=_s+'' index=_n+'']
      [%change-attr key=_s+'' del=[%a (list k=_s+'')] new=[%a (list [%a k=_s+'' v=_s+'' ~])]]
      [%text container-key=_s+'' data=_s+'']
  ==
::
:: ++make
:: produce a %mast component element.
++  make
  |=  $:  component=[desk=@tas file=path]
          params=(list [@tas cord])
          resources=(list [@tas path])
      ==
  ^-  manx
  :_  ~
  :*  :-  %mast  (spat component)
      %+  weld
      %+  turn  params
      |=  [k=@tas v=cord]
      :-  [%gust k]  (trip v)
      %+  turn  resources
      |=  [k=@tas v=path]
      :-  [%gale k]  (spud v)
  ==
::
--

