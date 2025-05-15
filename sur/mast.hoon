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
      src=(unit ship)                            ::   src, null unless mode is %auth
      par=gust                                   ::   params
      res=gale                                   ::   resources
  ==                                             ::
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
+$  lake  (map knot hook)                        :: base path to root component bindings
+$  line                                         :: component state identity
  $:  src=(unit ship)                            ::
      com=hook                                   ::
      par=gust                                   ::
      res=tide                                   ::
  ==                                             ::
+$  rope  (set @)                                :: containing parent key hashes
+$  deck  (map line bitt)                        :: component state map
+$  bitt                                         :: component state
  $:  mod=mode                                   ::
      bom=boom                                   ::
      rop=rope                                   ::
      aft=manx                                   ::
  ==                                             ::
+$  tide  (map @tas path)                        :: current resources
+$  pool  (set [com=hook par=gust res=tide])     :: nested component element data

+$  buoy  [?(%add %del) p=rope]                  :: subscription effect
+$  sunk                                         :: component creation error
  $%  [%missing-component desk=@tas file=@tas]   ::
      [%missing-resource =path]                  ::
      [%no-tube fil=path for=mark]               ::
  ==                                             ::

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
          key=tape
          params=(list [@tas cord])
          resources=(list [@tas path])
      ==
  ^-  manx
  :_  ~
  :*  :-  %mast  (spat component)
      :-  %key  key
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

