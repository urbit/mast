/-  mast, *circles
/+  lucide
^-  mast:mast
:-  :~  below+%circles-below
    ==
|_  =hull:mast
::
+*  get-below  !<  [path (list post-id)]  fil:(~(got by res.hull) %below)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ?+  route=((pole @ta) path.crow)  ~
    ::
      [%submit %post ~]
    ~
  ==
::
++  sail
  ^-  manx
  =/  [where=path kids=(list post-id)]  get-below
  ;div
    ;*
      =;  =marl  ?^  marl  marl
        ;=
          ;div.flex.p-8.items-center.justify-center
            ; no replies
          ==
        ==
    %+  turn  kids
    |=  =post-id
    =/  id  (scot %da post-id)
    =/  where  (snoc where id)
    ;div.pl-6
      ;+  %^  make:mast  %circles-unread-replies
        :~  [%where (spat where)]
        ==
      :~  [%new-below (welp /new-posts-below/[(scot %p src.hull)] where)]
      ==
    ==
  ==
--
