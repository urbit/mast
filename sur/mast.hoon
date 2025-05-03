|%
+$  crow  [=path data=(map @t @t)]               :: client event
+$  blow                                         :: event effects
  $:  pok=(list (pair @tas cage))                ::
      loc=$@(~ vase)                             ::
  ==                                             ::
+$  prop  (map @tas vase)                        :: component props state
+$  coms  (list term)                            :: component list
+$  kids  (list path)                            :: :: TODO:
+$  scud                                         :: component context
  $:  $:  our=ship                               ::   server
          yon=ship                               ::   client
      ==                                         ::
      $:  now=@da                                ::   now
          eny=@uvJ                               ::   entropy
      ==                                         ::
      $:  com=coms                               ::   all available components
          byk=beak                               ::   beak
          pax=path                               ::   resource path
          kid=kids                               ::   data under resource
      ==                                         ::
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
+$  line  (pair term path)                       :: component name + file path
+$  rope  (list line)                            :: component locational id
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
+$  loot  (map line prop)                        :: props for components to render
+$  buoy  [?(%add %del) p=ship q=rope]           :: subscription effect
+$  sunk                                         :: component creation error
  $%  [%missing-component-file name=@tas]        ::
      [%missing-local-resource =path]            ::
      [%no-tube fil=path com=mark]               ::
  ==                                             ::
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
+$  card  card:agent:gall
::
::
:: ++make
:: produce a component element.
:: takes the name of the component, a filesystem path to render,
:: and a list of props that are limited to tape values.
++  make
  |=  [component=term file=path limited-props=(list [@tas tape])]
  ^-  manx
  [[[%mast component] (snoc limited-props [%path (spud file)])] ~]
::
:: ++make-hoot
:: produce a component element when a ++sail arm is in hoot mode.
:: works the same as ++make,
:: but lets you pass in a list of full props with vase values.
++  make-hoot
  |=  [component=term file=path props=(list [@tas vase])]
  ^-  manx:hoot
  =;  pop
    [[[%mast component] [[%prop pop] [%path (spud file)] ~]] ~]
  ^-  (list beer:hoot)
  %+  turn  props
  |=  [k=@tas v=vase]
  ^-  beer:hoot
  :-  ~
  :*  [%rock [%tas k]]
      [%hand [p.v [%1 q.v]]]
  ==
::

--

