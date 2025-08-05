/-  mast, *circles
/+  lucide, *helpers
^-  mast:mast
:-  :~  post+%circles-post
    ==
|_  =hull:mast
::
+*  get-post  !<  post  fil:(~(got by res.hull) %post)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ~
::
++  sail
  ^-  manx
  =/  id  (trip (~(gut by par.hull) 'id' 'none'))
  =/  [author=@p content=@t]  get-post
  =/  [subject=tape body=wall]  (split-content content)
  ;div
    ;a.flex.gap-2
      =href  "/circles/{id}"
      ;span.font-mono
        ;-  (cite:title author)
      ==
      ;span.text-neutral-bright
        ;-  subject
      ==
    ==
  ==
--
