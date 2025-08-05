/-  mast, circles
/+  lucide, *helpers
^-  mast:mast
:-  :~  id+%circles-unit-path
        initialized+%circles-flag
    ==
|_  =hull:mast
::
+*  get-id  !<  (unit path)  fil:(~(got by res.hull) %id)
    get-initialized  !<  flag  fil:(~(got by res.hull) %initialized)
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
      [%click %initialize-user ~]
    :~  [%circles-action !>([%initialize-user ~])]
    ==
  ==
::
++  sail
  ^-  manx
  =/  initialized  get-initialized
  ?~  gid=get-id
    ;div: there is no post here
  =/  where=path  (need gid)
  |^
    ?:  &(!initialized =(where /))
      ;div.flex.flex-col.w-full.h-full.items-center.justify-center
        ;div.max-w-lg
          ;+  page-welcome
        ==
      ==
    ;div.px-4.pt-4.pb-20.flex.flex-col.gap-4
      ;+  part-header
      ;div.mx-auto.max-w-4xl.w-full.flex.flex-col.gap-4
        ;+  part-above
        ;+
          ?.  initialized
            page-welcome
          part-below
      ==
    ==
  ++  part-header
    ;header.flex.align-items.justify-between.gap-4
      ;a.border.rounded-sm.p-1
        =href  "/circles/recent"
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
      ;+  part-pager
    ==
  ++  form-create
    ;form.relative.border.rounded-sm.flex.items-stretch
      =event  "/submit/create"
      ;expanding-textarea.py-1.px-2.grow.text-neutral-bright
        =placeholder  "reply"
        =name  "content"
        =required  ""
        ;
      ==
      ;button.p-1.flex.flex-col.justify-end: →
    ==
  ++  part-subtree
    %^  make:mast  %circles-below
      ~
    :~  [%below (welp /below where)]
    ==
  ++  part-pager
    %^  make:mast  %circles-pager
      ~
    :~  [%new-posts /new-posts/[(scot %p src.hull)]]
    ==
  ++  page-welcome
    ;div.flex.flex-col.items-center.justify-center.gap-4.w-full.text-center.p-4.border.rounded-sm
      ;div: Welcome to Circles.
      ;div
        Circles is a forum designed to enable *small, closed groups*
        to have *in-depth discussions* over a *long period of time*.
      ==
      ;button.px-2.py-1.border.rounded-sm
        =event  "/click/initialize-user"
        ; Begin
      ==
    ==
  --
--
