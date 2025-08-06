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
  ?+  route=((pole @ta) path.crow)  ~
    ::
      [%click %read where=*]
    :~  [%circles-action !>([%mark-read where.route])]
    ==
  ==
::
++  sail
  ^-  manx
  =/  id  (trip (~(got by par.hull) 'id'))
  =/  where  (stab (~(got by par.hull) 'where'))
  =/  pate  ?~(where "" (spud where))
  =/  [author=@p content=@t]  get-post
  =/  [subject=tape body=wall]  (split-content content)
  ;a.block
    =href  "/circles/{id}"
    =event  "/click/read{pate}"
    ;+
      =/  class
        ?:  =(`'yes' (~(get by par.hull) %unread))
          "text-neutral-bright "
        "text-neutral-dim "
    ;span
      =class  class
      ;-  subject
    ==
    ;+  ?~  body  ;/  ""
      ;span.opacity-50.ml-2: ¶
    ;span.font-mono.float-right.text-sm
      ;-  (cite:title author)
    ==
  ==
--
