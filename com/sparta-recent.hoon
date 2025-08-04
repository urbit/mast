/-  mast, athens
^-  mast:mast
:-  :~  recent+%sparta-recent
    ==
:: =<
|_  =hull:mast
::
+*  rec  !<  
            (list [id=post-id:athens =post:athens tree=(map post-id:athens post:athens)])
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
      ;*  %+  turn  rec
      |=  [id=post-id:athens =post:athens tree=(map post-id:athens post:athens)]
      ;a.flex.flex-col.pointer
        =href  "./{(scow %da id)}"
        ;div.flex.flex-col.ml-2.relative
          ;div(class "absolute w-px bg-[var(--grey-default)] top-[14px] bottom-[14px] left-[8px]");
          ;*  %+  turn  ~(tap by tree)
          |=  [id=post-id:athens p=post:athens]
          ;div.flex.gap-2.text-sm
            ;div
              =class  "p-1 text-[var(--grey-default)]"
              •
            ==
            ;span.text-white: {(cite:title author.post)}
            ;span: {(trip content.p)}
          ==
          ;div.flex.gap-2.text-base
            ;div
              =class  "p-1 text-[var(--grey-default)]"
              •
            ==
            ;span.text-white: {(cite:title author.post)}
            ;span: {(trip content.post)}
          ==
        ==
      ==
    ==
  ==
::
--