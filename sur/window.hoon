|%
+$  window
  $~  [%$ *pane]
  $%  [%$ pane]
      [%h top=window bot=window]
      [%v lef=window rig=window]
  ==
+$  pane
  $:  component=term
      =path
  ==
+$  place     ?(%l %r %t %b)
+$  position  (list place)
+$  open      (pair (unit place) pane)
--

