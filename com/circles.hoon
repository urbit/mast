/-  mast, circles
/+  lucide, *helpers
^-  mast:mast
:-  :~  id+%circles-unit-path
    ==
|_  =hull:mast
::
+*  get-id  !<  (unit path)  fil:(~(got by res.hull) %id)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  =/  where=path  (need get-id)
  ?+  route=((pole @ta) path.crow)  ~
    ::
      [%submit %create ~]
    =/  content  (~(got by data.crow) 'content')
    :~  [%circles-action !>([%create-post where content])]
    ==
  ==
::
++  sail
  ^-  manx
  ?~  gid=get-id
    ;div: there is no post here
  =/  where=path  (need gid)
  |^
    ;div.px-4.pt-4.pb-20.flex.flex-col.gap-4
      ;+  part-header
      ;div.mx-auto.max-w-4xl.w-full.flex.flex-col.gap-4
        ;+  part-above
        ;+  part-below
      ==
    ==
  ++  part-header
    ;header.flex.align-items.justify-between.gap-4
      ;a
        ; recent
      ==
      ;div.flex.items-center.gap-2.border.rounded-sm.p-1
        ;urbit-sigil
          =patp  (cite-as-planet src.hull)
          ;
        ==
        ;div.font-mono: {(cite:title src.hull)}
      ==
    ==
  ++  part-above
    %^  make:mast  %circles-above
      ~
    :~  [%above (welp /above where)]
    ==
  ++  part-below
    ;div.flex.flex-col.gap-4
      ;+  form-create
      ;+  part-subtree
    ==
  ++  form-create
    ;form.relative.border.rounded-sm.flex.items-stretch
      =event  "/submit/create"
      =client-display  "replying true"
      ;textarea.py-1.px-2.grow.h-fit
        =placeholder  "reply"
        =rows  "1"
        =name  "content"
        =required  ""
        ;
      ==
      ;button.p-1: →
    ==
  ++  part-subtree
    %^  make:mast  %circles-below
      ~
    :~  [%below (welp /below where)]
    ==
  --
--
