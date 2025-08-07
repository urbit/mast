/-  mast, circles
/+  lucide, *helpers
^-  mast:mast
:-  :~  id+%circles-unit-path
        access+%circles-access
        initialized+%circles-flag
    ==
=<
|_  =hull:mast
::
+*  get-id      !<  (unit path)  fil:(~(got by res.hull) %id)
    get-access  !<  access:circles  fil:(~(got by res.hull) %access)
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
    ::
  ==
::
++  sail
  ^-  manx
  =/  initialized  get-initialized
  ?~  gid=get-id
    ;div.w-full.h-full.flex.flex-col.gap-3.items-center.justify-center
      ;div: there is no post here
      ;a.border.rounded-sm.px-2.py-1
        =href  "/circles"
        ; home
      ==
    ==
  =/  where=path  (need gid)
  =/  access  get-access
  =/  authenticated-user=(unit @p)  (has-access src.hull access)
  =/  is-logged-in=?  |(?=(^ authenticated-user) =(our.hull src.hull))
  =/  redirect-to  "/{(trip bas.hull)}"
  =/  user=@p  (fall authenticated-user src.hull)
  |^
    ?:  &(!initialized =(where /))
      ;div.flex.flex-col.w-full.h-full.items-center.justify-center
        ;div.max-w-lg
          ;+  page-welcome
        ==
      ==
    ;div
      ;+
        ?.  |(=(our.hull src.hull) is-logged-in)
          unauthenticated-page
        authenticated-page
    ==
  ++  authenticated-page
    ;div.flex.flex-col
      ;+  part-header
      ;div.mx-auto.max-w-4xl.w-full.flex.flex-col.gap-4.px-4.pt-4.pb-20
        ;+  part-above
        ;+
            ?.  initialized
              page-welcome
            part-below
      ==
    ==
  ++  part-header
    ;div.flex.flex-col.sticky.top-0.z-10
      ;header.flex.align-items.justify-between.p-4.pb-0.bg-neutral-bg
        ;a.border.rounded-sm.py-1.px-2.invisible
          =href  "/circles/recent"
          ; recent
        ==
        ;a.px-2.py-1.rounded-sm.border.bg-neutral-bg.flex.items-center.gap-2.text-sm
          =href  "/circles/settings"
          ;urbit-sigil
            =patp  (cite-as-planet src.hull)
            ;
          ==
          ;div.font-mono: {(cite:title src.hull)}
        ==
      ==
      ;div.h-10.pointer-events-none
        =style  "background: linear-gradient(to bottom, var(--color-neutral-bg), rgba(0, 0, 0, 0));"
        ; 
      ==
    ==
  ++  part-above
    %^  make:mast  %circles-above
      ~
    :~  [%above (welp /above where)]
        [%replies (welp /replies where)]
    ==
  ++  part-below
    ;div.flex.flex-col.gap-4.px-2
      ;+  form-create
      ;+  part-subtree
      ;+  part-pager
    ==
  ++  form-create
    ;form
      =class  "border rounded-sm leading-normal rounded-md ".
              "overflow-hidden flex items-stretch ".
              "md:shadow-none md:p-0 ".
              "items-stretch [&.is-focused]:!border-white [&.is-focused]:!text-white" 
      =event  "/submit/create"
      ;expanding-textarea.py-1.px-2.grow.text-neutral-bright
        =placeholder  "reply"
        =name  "content"
        =required  ""
        ;
      ==
      ;button
        =class  "mt-auto p-2 text-[14px] h-[28px] flex items-center justify-center"
        ; →
      ==
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
      ;button.px-2.py-1.border.rounded-sm.hover
        =event  "/click/initialize-user"
        ; Begin
      ==
    ==
  ++  unauthenticated-page 
    |^
      ?:  =(mode.access %gated)
        ?:  =('' door-code.access)
          ;div
            =class  "h-full w-full flex flex-col gap-5 ".
                    "items-center justify-center"
            ;div.font-bold: Unavailable
            ;div: The host needs to set the "door code" before you can register.
            ;a.underline
              =href  "/~/login?redirect={redirect-to}"
              ; login as host
            ==
          ==
        gated-login
      normal-login
    ::
    ++  gated-login
      ;div
        =class  "h-full w-full flex flex-column ".
                "items-center justify-center font-mono "
        ;div.flex.flex-col.items-center.gap-5
          ;div: unauthenticated
          ;hr.w-20.opacity-70;
          ;form.flex.scroll-none.border.rounded-sm.border-neutral-800
            =method  "post"
            =event  "/submit/register"
            ;input#register-input.hidden(name "fingerprint");
            ;input
              =name  "door-code"
              =class  "px-3 py-2 border-neutral-800 w-35"
              =placeholder  "door code"
              =required  ""
              =spellcheck  "false"
              =autocomplete  "off"
              =onkeydown  "if (event.key == 'Enter') \{ this.nextElementSibling.click() }"
              ;
            ==
            ;button.bg-neutral-900.px-3.py-2.border-l.rounded-r-sm.border-neutral-800
              =type  "button"
              =onclick  "register(event)"
              ; register
            ==
          ==
          ;div.font-mono.opacity-70: or
          ;form.flex.gap-2
            =method  "post"
            =event  "/submit/sign-in"
            ;input#sign-in-input.hidden(name "fingerprint", required "");
            ;button.bg-neutral-900.px-3.py-2.rounded-sm.border.border-neutral-800
              =type  "button"
              =onclick  "signIn(event)"
              ; sign in
            ==
          ==
        ==
      ==
      ++  normal-login
      ;form
        =class  "h-full w-full flex flex-column ".
                "items-center justify-center "
        =method  "post"
        =action  "/~/login"
        ;input.hidden(name "eauth", value "");
        ;input.hidden(name "redirect", value redirect-to);
        ;div.flex.flex-col.gap-3.border.rounded-md.p-3.border-neutral-800
          ;div.text-red-400: access denied
          ;+
          ?:  !is-logged-in  ;/("")
          ;div.flex.gap-2
            ;div.font-mono: {(cite:title user)}
            ;a.opacity-50(href "/~/logout?redirect={redirect-to}")
              ; logout
            ==
          ==
          ;div.flex.gap-2
            ;input
              =name  "name"
              =class  "px-3 py-2 border rounded-sm border-neutral-800 w-60"
              =placeholder  "~sampel-palnet"
              =spellcheck  "false"
              =autocomplete  "off"
              ;
            ==
            ;button.bg-neutral-900.px-3.py-2.rounded-sm.border.border-neutral-800
              ;+  arrow-right:lucide
            ==
          ==
        ==
      ==
    --
  --
--
|%
::
++  has-access
  |=  [=ship =access:circles]
  ^-  (unit @p)
  ?-  mode.access
    %gated
      (~(get by accounts.access) ship)
    %public
      ?:  ?=(~ (find [ship]~ blacklist.access))
        `ship
      ~
    %private
      ?:  ?=(^ (find [ship]~ members.access))
        `ship
      ~
  ==
--
