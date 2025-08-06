/-  mast, *circles
^-  mast:mast
:-  :~  recent+%circles-recent
    ==
|_  =hull:mast
::
+*  rec  !<  
            (list (list (pair path post)))
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
  ;div.w-full.h-full.flex.flex-col.gap-3.items-center.justify-center
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
      |=  chain=(list (pair path post))
      =/  above  (snip chain)
      =/  pos=(pair path post)  (rear chain)
      ;a.flex.flex-col.pointer
        =href  "./{(trip (rear `(list @tas)`p.pos))}"
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
            ;span.text-white: {(cite:title author.q.pos)}
            ;span: {(trip content.q.pos)}
          ==
        ==
      ==
    ==
  ==
::
--