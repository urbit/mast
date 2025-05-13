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
+$  brig                                         :: auth component sample
  $:  src=ship                                   ::
      hull                                       ::
  ==                                             ::
+$  hull                                         :: component sample
  $:  our=ship                                   ::
      par=gust                                   ::
      res=gale                                   ::
  ==                                             ::
+$  gust  (map @tas @t)                          :: component params
+$  gale                                         :: component resources
  %+  map  @tas                                  ::
  $:  src=path                                   ::
      dir=(list path)                            ::
      fil=vase                                   ::
  ==                                             ::
+$  clew  (list (pair cord cord))                :: client state object init
+$  boom                                         :: resource spec
  %-  list                                       ::
  $:  name=@tas                                  ::   key
      mark=@tas                                  ::   mark, potentially converted to
      care=?(%x %z)                              ::   %x no kids, %z kids
  ==                                             ::
+$  mast                                         :: component core                     :: TODO: refactor +$mast
  $^  $:  [boom clew]                            ::   the default component creates
          $_  ^|                                 ::   a publicly accessible, cached 
          |_  hull                               ::   branch, unless it nests under
          ++  spar  *$-(crow blow)               ::   an auth component branch
          ++  sail  *manx                        ::
          --                                     ::
      ==                                         ::
  $%  $:  %auth                                  :: auth component
          [boom clew]                            ::   creates a branch that enables
          $_  ^|                                 ::   client specific authorization
          |_  brig                               ::   and rendering logic
          ++  spar  *$-(crow blow)               ::
          ++  sail  *manx                        ::
          --                                     ::
      $:  %root                                  :: root component
          $-  keel                               ::   used to define the root of your
          $^                                     ::   interface, and all valid routes
          $_
          ;html
            ;head
              ;*  *marl
            ==
            ;+  :~  [%body *mart]
                :-  [[%mast *@tas] *mart]
                    *marl
                ==
          ==
          $%  [%redirect p=path]
          ==
      ==
  ==
+$  bind  [name=knot =desk file=path]            :: bind base path name to root component
::
  ::
::
+$  lake  (map knot dock)                        :: all base paths to components
+$  line  cord                                   :: component key
+$  rope  (list line)                            :: component locational id
+$  dock  (map quay bitt)                        :: routes to components
+$  deck  (map $@(line [ship line]) bitt)        :: nested components
+$  bitt                                         :: component state
  $:  bom=boom
      par=gust
      res=tide
      aft=manx
      kid=deck
  ==
+$  tide  (map @tas path)                        :: current resources
+$  pool  (map line [par=gust res=tide])         :: nested component element data on render
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
      :-  [%para k]  (trip v)
      %+  turn  resources
      |=  [k=@tas v=path]
      :-  [%path k]  (spud v)
  ==
::
--

