/-  mast, *circles
^-  mast:mast
:-  :~  recent+%circles-recent
    ==
|_  =hull:mast
::
+*  rec  !<  
            (list [id=post-id =post above=(list (pair path post))])
            fil:(~(got by res.hull) %recent)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ?+  path.crow  ~
    ~  ~
  ==
::
++  sail
  ^-  manx
  ;div
    ;div
      ;*
      ?~  rec  
        ;=
          ;div.flex.flex-col.pointer
            ;span: Recent posts empty
            ;a(href "./"): back
          ==
        ==
      %+  turn  rec
      |=  [id=post-id pos=post above=(list (pair path post))]
      ;a.flex.flex-col.pointer
        =href  "./{(scow %da id)}"
        ;div.flex.flex-col.ml-2.relative
          ;div(class "absolute w-px bg-[var(--grey-default)] top-[14px] bottom-[14px] left-[8px]");
          ;*  %+  turn  above
          |=  [paf=path p=post]
          ;div.flex.gap-2.text-sm
            ;div
              =class  "p-1 text-[var(--grey-default)]"
              •
            ==
            ;span.text-white: {(cite:title author.p)}
            ;span: {(trip content.p)}
          ==
          ;div.flex.gap-2.text-base
            ;div
              =class  "p-1 text-[var(--grey-default)]"
              •
            ==
            ;span.text-white: {(cite:title author.pos)}
            ;span: {(trip content.pos)}
          ==
        ==
      ==
    ==
  ==
::
--