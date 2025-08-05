/-  mast, *circles
/+  lucide
^-  mast:mast
:-  :~  new-posts+%circles-set-path
    ==
|_  =hull:mast
::
+*  get-new  !<  (set path)  fil:(~(got by res.hull) %new-posts)
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
  =/  new=(set path)  get-new
  =/  sorted=(list path)
    %+  sort  ~(tap in new)
    |=  [a=path b=path]
    ?~  a  %.n
    ?~  b  %.y
    %+  gth
      (slav %da (rear `path`a))
    (slav %da (rear `path`b))
  ;div.flex.flex-col.border.px-2.py-1.rounded-sm.fixed.bottom-2.right-2.bg-neutral-bg.z-2
    ;+
    ?~  sorted
      ;div: no new
    =/  pax=path  i.sorted
    =/  pate  ?~  pax  ""  (spud pax)
    =/  id=tape  ?~  pax  ""  "/{(trip (rear `path`pax))}"
    ;a.primary-action
      =href  "/circles{id}"
      =event  "/click/read{pate}"
      ; {<(lent sorted)>} new
    ==
  ==
--
