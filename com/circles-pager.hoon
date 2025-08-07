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
    %+  lth
      (slav %da (rear `path`a))
    (slav %da (rear `path`b))
  ;div
    =class  "flex flex-col fixed z-2 ".
            "bottom-4 right-4 md:bottom-9 md:right-9 "
    ;+
    ?~  sorted
      ?~  rut.hull  ;/  ""
      ;a.primary-action.px-2.py-1.border.rounded-sm.bg-neutral-bg
        =href  "/circles"
        ; home
      ==
    =/  pax=path  i.sorted
    =/  pate  ?~  pax  ""  (spud pax)
    =/  id=tape  ?~  pax  ""  "/{(trip (rear `path`pax))}"
    ;a.primary-action.px-3.py-1.bg-neutral-bg.text-lg.rounded-sm
      =style  "filter: invert(100%);"
      =href  "/circles{id}"
      =event  "/click/read{pate}"
      ; {<(lent sorted)>} new →
    ==
  ==
--
