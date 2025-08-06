/-  mast, *circles
/+  lucide
^-  mast:mast
:-  :~  new-below+%circles-set-path
    ==
|_  =hull:mast
::
+*  get-new-below  !<  (set path)  fil:(~(got by res.hull) %new-below)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ?+  route=((pole @ta) path.crow)  ~
    ::
      ~
    ~
  ==
::
++  sail
  ^-  manx
  =/  where=path  (stab (~(got by par.hull) %where))
  =/  new-below  get-new-below
  =/  full-new-tree=(axal ~)
    %-  ~(gas of *(axal ~))
    %+  turn  ~(tap in new-below)
    |=  =path
    [path ~]
  =/  new-tree=(axal ~)
    (~(dip of full-new-tree) where)
  =/  pax=path  where
  =|  dep=@
  =|  seg=(unit @ta)
  |-
  =/  id=@ta  ?~(seg (rear where) u.seg)
  ;div.flex.flex-col
    ;div
      ;+  %^  make:mast  %circles-summary
          :~  [%id id]
              [%where (spat pax)]
              [%unread ?:(?=(^ fil.new-tree) 'yes' 'no')]
          ==
        :~  [%post :(welp /post pax)]
        ==
    ==
    ;div.ml-1.pl-2.border-l
      ;*
      %+  turn  ~(tap by dir.new-tree)
      |=  [=@ta below=_new-tree]
      ^$(new-tree below, pax (snoc pax ta), dep +(dep), seg `ta)
    ==
  ==
--
