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
  ;a.block
    =href  "/circles/{id}"
    ;+
      =/  class
        ?:  =(`'yes' (~(get by par.hull) %unread))
          "text-neutral-bright "
        "text-neutral-dim "
    ;span
      =class  class
      ;-  subject
    ==
    ;span.font-mono.float-right.text-sm
      ;-  (cite:title author)
    ==
  ==
--
