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
  =/  access  get-access
  =/  fingerprint-to-id
    |=  fingerprint=cord
    ^-  @p
    (fil 5 3 (muk 'seed' (as-octs:mimes:html fingerprint)))
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
      [%input %set-access-mode ~]
    =/  mode  (~(got by data.crow) '/target/mode')
    :~  [%circles-action !>([%set-access-mode mode])]
    ==
    ::
      [%submit %set-door-code ~]
    =/  code  (~(got by data.crow) 'code')
    :~  [%circles-action !>([%gated-set-door-code code])]
    ==
      [%submit %add-ship ~]
    =/  dat  (~(got by data.crow) 'ship-input')
    ?:  =('' dat)  ~
    :~  [%circles-action !>([%edit-access-id [`@p`(slav %p dat)]~])]
    ==
      [%submit %remove-ship ~]
    =/  dat  (~(got by data.crow) 'ship-input')
    ?:  =('' dat)  ~
    :~  [%circles-action !>([%del-access-id (slav %p dat)])]
    ==
      [%submit %register ~]
    =/  fingerprint=@p
      %-  fingerprint-to-id
      (~(got by data.crow) 'fingerprint')
    =/  door-code=@t  (~(got by data.crow) 'door-code')
    ?.  =(door-code door-code.access)
      ~
    :~  [%circles-action !>([%gated-sign-in src.hull fingerprint])]
    ==
      [%submit %sign-in ~]
    =/  fingerprint=@p
      %-  fingerprint-to-id
      (~(got by data.crow) 'fingerprint')
    ?.  ?=(^ (find ~[fingerprint] ~(val by accounts.access)))
      ~     :: fail sign-in if the user does not have an account
    :~  [%circles-action !>([%gated-sign-in src.hull fingerprint])]
    ==
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
    ;div.px-4.pt-4.pb-20.flex.flex-col.gap-4
      ;+
        ?.  |(=(our.hull src.hull) is-logged-in)
          unauthenticated-page
        authenticated-page
    ==
  ++  authenticated-page
  ;div
    ;+  %-  make-client-state:mast
      :~
        [%sigil "closed"]
        [%show-ids "false"]
      ==
    ;+  part-header
    ;div.mx-auto.max-w-4xl.w-full.flex.flex-col.gap-4
      =client-event  "hover sigil closed"
      ;+  part-above
      ;+
          ?.  initialized
            page-welcome
          part-below
    ==
  ==
  ++  part-header
    ;header.flex.align-items.justify-between.gap-4
      ;a.border.rounded-sm.py-1.px-2
        =href  "/circles/recent"
        ; recent
      ==
      ;div
        =class  "flex flex-col gap-2 w-auto max-w-[160px] md:w-[160px] relative border-[var(--color-neutral-dark)]"
        ;div.flex.items-center.gap-2.border.rounded-sm.p-1
          =client-display  "sigil closed"
          =client-event  "mouseenter sigil open"
          ;urbit-sigil
            =patp  (cite-as-planet src.hull)
            ;
          ==
          ;div.font-mono: {(cite:title src.hull)}
        ==
        ;div
          =class  "flex items-center gap-2 border rounded-sm p-1 border-[var(--color-neutral-dim)]"
          =client-display  "sigil open"
          ;urbit-sigil
            =patp  (cite-as-planet src.hull)
            ;
          ==
          ;div.font-mono: {(cite:title src.hull)}
        ==
        ;div
          =class  "absolute top-[40px] z-10 border border-[var(--color-neutral-dim)] rounded bg-[var(--color-neutral-bg)] md:hover:flex w-[160px]"
          =client-display  "sigil open"
          ;+  ?.  =(our.hull src.hull)  
                user-menu
              admin-menu
        ==
      ==
    ==
  ++  user-menu
    ;div
      =class  "grid grid-cols-[auto_1fr] grid-rows-[repeat(auto-fit,28px)] ".
              "divide-y divide-[var(--color-neutral-dim)] leading-tight ".
              "max-h-[65vh] overflow-y-auto leading-[0.8] w-full"
      =client-event  "mouseleave sigil closed"
      ;div
        =class  "flex items-center h-[28px] overflow-hidden"
        ;a
          =class  "p-2 cursor-pointer col-span-2 flex items-center ".
                  "overflow-hidden text-[var(--color-neutral-dark)] ".
                  "hover:text-[var(--color-neutral-dim)]"
          =href  "/~/logout?redirect={redirect-to}"
          ; Sign out
        ==
      ==
    ==
  ++  admin-menu
    ;div
      =class  "grid grid-cols-[auto_1fr] grid-rows-[repeat(auto-fit,28px)] ".
              "divide-y divide-[var(--color-neutral-dim)] leading-tight ".
              "max-h-[65vh] overflow-y-auto leading-[0.8] w-full"
      =client-event  "mouseleave sigil closed"
      ;*
      %+  turn
        ^-  (list tape)
        :~  "Gated"
            "Public"
            "Private"
        ==
      |=  mode=tape
      ;label.col-span-2.px-2.flex.items-center.justify-start.gap-2
        ;+
          =;  m=manx
          ?.  =((crip (cass mode)) mode.access)  m
          m(a.g [[%checked ""] a.g.m])
        ;input
          =type  "radio"
          =name  "access-mode"
          =mode  (cass mode)
          =event  "/input/set-access-mode"
          =return  "/target/mode"
          ;
        ==
        ;span: {mode}
      ==
        ::
      ;*
        =/  class  "p-2 cursor-pointer col-span-2 ".
                   "flex justify-between items-center text-[var(--color-neutral-dark)] hover:text-[var(--color-neutral-dim)]"
        =/  btn-label
          ?-  mode.access
            %gated    "Door Code"
            %public   "Blocked"
            %private  "Members"
          ==
        ;=
          ;button
            =class  class
            =client-event  "click show-ids false"
            =client-display  "show-ids true"
            ;span: {btn-label}
            ;+  vector-in:lucide
          ==
          ;button
            =class  class
            =client-event  "click show-ids true"
            =client-display  "show-ids false"
            ;span: {btn-label}
            ;+  vector-out:lucide
          ==
        ==
        ;*  
          ?-  mode.access
            %gated
              ;=
                ;form(event "/submit/set-door-code")
                  =class  "col-span-2 px-2 w-full flex gap-2"
                  =client-display  "show-ids true"
                  ;input(type "text", name "code")
                    =class  "border-0 focus:outline-none text-white w-full leading-tight"
                    =placeholder  "door code"
                    =autocomplete  "off"
                    =spellcheck  "false"
                    =value  (trip door-code.access)
                    ;
                  ==
                ==
              ==
            %public
              ;=
                ;*  (edit-access-form mode.access)
                ;*  (id-list blacklist.access)
              ==
            %private
              ;=
                ;*  (edit-access-form mode.access)
                ;*  (id-list members.access)
              ==
          ==
    ==
  ++  edit-access-form
    |=  mode=access-mode:circles
    ^-  marl
    ?:  ?=(%gated mode)  ~
    ;=
      ;form(event "/submit/add-ship")
        =class  "col-span-2 px-2 w-full flex gap-2 h-[28px]"
        =client-display  "show-ids true"
        ;+  ?:  ?=(%public mode)
          ;button.ml-auto.cursor-pointer: ~
        ;button.ml-auto.cursor-pointer: +
        ;input(type "text", name "ship-input")
          =class  "border-0 focus:outline-none text-white w-full leading-tight"
          =autocomplete  "off"
          =spellcheck  "false"
          ;
        ==
      ==
    ==
  ++  id-list 
    |=  ids=(list @p)
    ^-  marl
    ;*  %+  turn  ids
    |=  =ship
    ^-  manx
    ;div
      =class  "col-span-2 flex gap-auto text-[var(--color-neutral-dark)] hover:*:text-[var(--color-neutral-dim)]"
      =client-display  "show-ids true"
      ;div(class "mt-auto p-2 h-[28px] flex items-center justify-center"): {(scow %p ship)}
      ;form
        =event  "/submit/remove-ship"
        =class  "ml-auto mt-auto p-2 h-[28px] flex items-center justify-center"
        =id  (scow %p ship)
        ;input.hidden(type "hidden", name "ship-input", value (scow %p ship));
        ;button(class "cursor-pointer"): x
      ==
    ==
  ++  part-above
    %^  make:mast  %circles-above
      ~
    :~  [%above (welp /above where)]
    ==
  ++  part-below
    ;div.flex.flex-col.gap-4.px-2
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
      ;button.p-1.flex.flex-col.justify-end.hover: →
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
