/-  mast, *circles
/+  *helpers
^-  mast:mast
:-  ~
|_  =hull:mast
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ?+  route=((pole @ta) path.crow)  ~
    ~  ~
  ==
++  sail
  ^-  manx
  |^
    ;div.m-auto.w-full.max-w-4xl.flex.flex-col.gap-6.p-4
      ;+  header
      ;+  ?.  =(our.hull src.hull)  ;/  ""
          %^  make:mast  %admin-settings  ~
          :~  [%access /access]
          ==
      ;+  overview
    ==
  ++  header
    ;header.flex.justify-between
      ;a.px-2.py-1.border.rounded-sm.bg-neutral-bg
        =href  "/circles"
        ; back
      ==
      ;div.flex.items-center.gap-3
        ;div.font-mono.text-sm: {(cite:title src.hull)}
        ;a.px-2.py-1.bg-neutral-bg.border.rounded-sm
          =href  "/~/logout?redirect=/circles"
          ; logout
        ==
      ==
    ==
  ++  overview
    ;div.flex.flex-col.gap-3
      ;h1.font-bold.text-lg: Circles
      ;p
        Circles is a forum designed to enable small, closed groups to have in-depth discussions over a long period of time.
      ==
      ;hr;
      ;h2.font-bold: Keyboard Shortcuts

      - Spacebar: go to the next new post if there is one
      - Cmd+Enter: submit a new message

    ==
  --
--