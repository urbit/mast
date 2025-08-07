/-  mast, *circles
^-  mast:mast
:-  :~  recent+%circles-set-path
    ==
|_  =hull:mast
::
+*  get-new  !<  (set path)  fil:(~(got by res.hull) %recent)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ?+  route=((pole @ta) path.crow)  ~
    ::
    ~  ~
  ==
++  sail
  ^-  manx
  ;div.w-full.h-full.flex.flex-col.gap-3.items-center.justify-center
    ;div
      ;*
      ?~  get-new
        ;=
          ;div.flex.flex-col.pointer
            ;span: Recent posts empty
            ;a(href "./"): back
          ==
        ==
      %+  turn  ~(tap by get-new)
      |=  where=path
        %^  make:mast  %circles-above
        ~
        :~  [%above (welp /above where)]
            [%replies (welp /replies where)]
        ==
    ==
  ==
--