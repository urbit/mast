|%
+$  gull                                         :: poke, component --> agent
  $:  src=ship                                   ::   client id
      com=term                                   ::   component provenance
      dat=cage                                   ::   poke data
  ==                                             ::
+$  crow  [=path data=(map @t @t)]               :: event poke, client --> component
+$  blow  (list (pair @tas cage))                :: pokes emitted from a component
+$  quay                                         :: url + query params
  $:  url=path                                   ::
      wut=(map @t @t)                            ::
  ==                                             ::
+$  keel                                         :: root component sample
  $:  our=ship                                   ::
      quay                                       ::
  ==                                             ::
+$  brig                                         :: auth component sample
  $:  src=ship                                   ::
      hull                                       ::
  ==                                             ::
+$  hull                                         :: component sample
  $:  our=ship                                   ::
      pop=prop                                   ::
      sac=sack                                   ::
  ==                                             ::
+$  prop  (map @tas vase)                        :: component props
+$  sack  (map @tas loot)                        :: component resource map
+$  loot                                         :: resource data
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
          ++  sail  *$^(manx [%hoot manx:hoot])  ::
          --                                     ::
      ==                                         ::
  $%  $:  %auth                                  :: auth component
          [boom clew]                            ::   creates a branch that enables
          $_  ^|                                 ::   client specific authorization
          |_  brig                               ::   and rendering logic
          ++  spar  *$-(crow blow)               ::
          ++  sail  *$^(manx [%hoot manx:hoot])  ::
          --                                     ::
      $:  %root                                  :: root component
          $_                                     ::   used to define the root of your
          |~  keel                               ::   interface, and all valid routes
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
      ==
  ==
::
  ::
::
+$  line  @t                                     :: component key
+$  rope  (list line)                            :: component node id
+$  dock  (map quay bitt)                        :: routes to components
+$  deck  (map $@(line [ship line]) bitt)        :: nested components
+$  bitt                                         :: component state
  $:  bom=boom
      sac=sack
      aft=manx
      kid=deck
  ==
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
          props=(list [@tas cord])
          resources=(list [@tas path])
      ==
  ^-  manx
  :_  ~
  :*  :-  %mast  (spat component)
      :-  %key  key
      %+  weld
      %+  turn  props
      |=  [k=@tas v=tape]
      :-  [%prop k]  (trip v)
      %+  turn  resources
      |=  [k=@tas v=path]
      :-  [%path k]  (spud v)
  ==
::
:: ++make-hoot
:: produce a %mast component element
:: for a sail arm in %hoot mode,
:: allowing you to pass in vases as props.
++  make-hoot
  |=  $:  component=[desk=@tas file=path]
          key=tape
          props=(list [@tas vase])
          resources=(list [@tas path])
      ==
  ^-  manx:hoot
  :_  ~
  :*  :-  %mast  (spat component)
      :-  %key  key
      :_  %+  turn  resources
          |=  [k=@tas v=path]
          :-  [%path k]  (spud v)
      :-  %prop
      ^-  (list beer:hoot)
      %+  turn  props
      |=  [k=@tas v=vase]
      ^-  beer:hoot
      :-  ~
      :*  [%rock [%tas k]]
          [%hand [p.v [%1 q.v]]]
      ==
  ==
::
--

