/-  mast, athens
/+  lucide
^-  mast:mast
:-  :~  posts+%athens-post-list
        access+%athens-access
    ==
=<
|_  =hull:mast
::
+*  get-post-paths  !<  (list path)  fil:(~(got by res.hull) %posts)
    get-access      !<  access:athens  fil:(~(got by res.hull) %access)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  =/  access  get-access
  =/  pol  ^-  (pole @ta)  path.crow
  ?+  pol  ~
    ::
      [%submit %post ~]
    =/  dat  (~(got by data.crow) 'post-input')
    ?:  =('' dat)  ~
    :~  [%athens %athens-action !>([%put-post ~ dat])]
    ==
    ::
      [%submit %remove-ship ~]
    =/  dat  (~(got by data.crow) 'ship-input')
    ?:  =('' dat)  ~
    :~  [%athens %athens-action !>([%del-access-id (slav %p dat)])]
    ==
    ::
      [%submit %add-ship ~]
    =/  dat  (~(got by data.crow) 'ship-input')
    ?:  =('' dat)  ~
    :~  [%athens %athens-action !>([%edit-access-id [`@p`(slav %p dat)]~])]
    ==
    ::
      [%change %toggle-public ~]
    :~  [%athens %athens-action !>([%access-public !public.access])]
    ==
    ::
  ==
::
++  sail
  ^-  manx
  =/  access  get-access
  =/  is-comet=?  ?=(%pawn (clan:title src.hull))
  |^
    ;div.root
      ;+  (make-client-state:mast [reply+"~" edit+"~" show-settings+"false" show-ids+"true" ~])
      ;+
          ?:  |(=(our.hull src.hull) (has-access src.hull access))
            authenticated-page
          unauthenticated-page
    ==
  ++  authenticated-page
    ;div
      =class  "relative h-[112px] w-full"
      ;div
        =class  "fixed top-0 left-0 w-full h-[18vh] md:h-[9vh] ".
                "bg-gradient-to-b from-black/100 to-transparent ".
                "z-50 pointer-events-none"
        ;
      ==
      ;div
        =class  "user fixed z-100"
        ;+  ?:  is-comet  
              public-login-form
            header-menu
      ==
      ;div
        =class  "gradient fixed bottom-0 left-0 w-full h-[18vh] md:h-[9vh] ".
                "bg-gradient-to-t from-black/100 to-transparent z-50 ".
                "pointer-events-none"
        ;
      ==
      ;+  list-posts
    ==
  ++  header-menu
    ;div
      =client-event  "mouseenter show-settings true"
      =class  "border border-[#A3A3A3] rounded bg-[#0F0F0F]"
      ;div
      =client-event  "mouseleave show-settings false"
        ;div
          =class  "flex items-center justify-center ".
                  "p-[8px] h-[28px]"
          =client-display  "show-settings !true !font-mono"
          ;  {(cite:title src.hull)}
        == 
        ;+  ?.  =(our.hull src.hull)  
            user-menu
          admin-menu
      ==
    ==
  ++  user-menu
    ;div
      =class  "grid grid-cols-[auto_1fr] divide-y ".
              "divide-[#A3A3A3]"
      =style  "max-height: 400px; overflow-y: auto;"
      =client-display  "show-settings true"
      ;div.px-4.py-2: Urbit ID
      ;div.px-4.py-2
        ; {(cite:title src.hull)}
      ==
      ;a.px-4.py-2.cursor-pointer.col-span-2.flex.justify-center
        =href  "/~/logout?redirect=/mast/athens"
        ; Sign out
      ==
    ==
  ++  admin-menu
    ;div
      =class  "grid grid-cols-[auto_1fr] divide-y ".
              "divide-[#A3A3A3]"
      =style  "max-height: 400px; overflow-y: auto;"
      =client-display  "show-settings true"
      ;div.px-4.py-2
        ; Urbit ID
      ==
      ;div.px-4.py-2
        ; {(cite:title src.hull)}
      ==
      ;div.px-4.py-2
        ; Public Access
      ==
      ;label.px-4.py-2.w-full.flex.items-center.justify-end.relative
        ;div.relative.inline-block
          ;+
          ?:  public.access
            ;input.sr-only.peer
              =type  "checkbox"
              =event  "/change/toggle-public"
              =name  "toggle-access"
              =checked  ""
              ;*  toggle
            ==
          ;input.sr-only.peer
            =type  "checkbox"
            =event  "/change/toggle-public"
            =name  "toggle-access"
            ;*  toggle
          ==
        ==
      ==
      ;*
      ?:  public.access
        ;=
          ;div.px-4.py-2.cursor-pointer.col-span-2.flex.justify-between
            =client-display  "show-ids !true"
            =client-event  "click show-ids true"
            ;span: Blocked
            ;span: >
          ==
          ;div.px-4.py-2.cursor-pointer.col-span-2.flex.justify-between
            =client-display  "show-ids true"
            =client-event  "click show-ids false"
            ;span: Blocked
            ;span: <
          ==
          ;+  (edit-access-form public.access)
          ;*  (id-list blacklist.access)
        ==
      ;=
        ;div.px-4.py-2.cursor-pointer.col-span-2.flex.justify-between
          =client-display  "show-ids !true"
          =client-event  "click show-ids true"
          ;span: Members
          ;span: >
        ==
        ;div.px-4.py-2.cursor-pointer.col-span-2.flex.justify-between
          =client-display  "show-ids true"
          =client-event  "click show-ids false"
          ;span: Members
          ;span: <
        ==
        ;+  (edit-access-form public.access)
        ;*  (id-list members.access)
      ==
    ==
  ++  public-login-form
    ;form.flex
      =action  "/~/login"
      =method  "POST"
      ;label.p-2(for "login-input"): login:
      ;input(id "login-input", name "name", required "");
      ;input(type "hidden", name "redirect", value "/mast/athens");
      ;input(type "hidden", name "eauth", value "");
      ;button(type "submit")
        ;+  arrow-right:lucide
      ==
    ==
  ++  list-posts
    ;div
      =class  "posts md:gap-[16px] gap-[16px] relative"
      ;*  
        %+  turn  get-post-paths
        |=  =path
        %^  make:mast  mast/%athens-post  ~
        :~  [%post (weld /athens/posts path)]
            [%view (welp /athens/view/[(scot %p src.hull)] path)]
            [%new (weld /athens/new/[(scot %p src.hull)] path)] 
        ==
      ;div(class "fixed bottom-4 inset-x-0 z-50 md:w-full") 
        =key  "athens-post-form"
        ;div(class "mx-auto max-w-[1000px]")
          ;div
            =class  "md:grid md:grid-rows-[min-content] md:grid-cols-3 ".
                    "md:items-start md:grid-cols-[14ch_auto_120px] mx-4 ".
                    "z-50 md:gap-x-4 form-post-wrapper "
            ;+  ?:  is-comet
                  ;div.post-form.login-block: Login to post
                ;form(event "/submit/post")
                  =class  "post-form form-border rounded-md shadow-md bg-[#0F0F0F] ".
                          "overflow-hidden box-border flex ".
                          "md:col-start-2 md:rounded-none md:shadow-none md:p-0 ".
                          "items-stretch [&.is-focused]:!border-white [&.is-focused]:!text-white" 
                  ;athens-textarea-litdev.grow
                    =name  "post-input"
                    ;
                  ==
                  ;button
                  =class  "mt-auto p-2 text-[14px]"
                    ; →
                  ==
                ==
          ==
        ==
      ==
    ==
  ++  unauthenticated-page
    ;form
      =class  "h-full w-full flex flex-column ".
              "items-center justify-center "
      =method  "post"
      =action  "/~/login"
      ;input.hidden(name "eauth", value "");
      ;input.hidden(name "redirect", value "/mast/athens");
      ;div.flex.flex-col.gap-3.border.rounded-md.p-3.border-neutral-800
        ;div.text-red-400: access denied
        ;+
        ?:  is-comet  ;/("")
        ;div.flex.gap-2
          ;div.font-mono: {(cite:title src.hull)}
          ;a.opacity-50(href "/~/logout?redirect=/mast/athens")
            ; logout
          ==
        ==
        ;div.flex.gap-2
          ;input
            =name  "name"
            =class  "font-mono px-3 py-2 border rounded-sm border-neutral-800 w-60"
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
::
--
|%
::
++  has-access
  |=  [=ship =access:athens]
  ^-  ?
  ?:  public.access 
    ?=(~ (find [ship]~ blacklist.access))
  ?=(^ (find [ship]~ members.access))
::
++  toggle
  ^-  marl
  ;=
    ;div(class "w-[20px] h-[11px] bg-[#A3A3A3] rounded-full transition-colors");
    ;div(class "absolute left-[0] top-[0] w-[9px] h-[9px] bg-[#0F0F0F] rounded-full transition-transform transform peer-checked:translate-x-full m-[1px]");
  ==
::
++  edit-access-form
  |=  public=?
  ^-  manx
  ;form.col-span-2.px-4.py-2.flex(event "/submit/add-ship")
    ;input(type "textbox", name "ship-input")
      =class  "border-0 focus:outline-none text-white"
    ;
    ==
    ;+  ?:  public
      ;button.ml-auto: ~
    ;button.ml-auto: +
  ==
::
++  id-list
  |=  ids=(list @p)
  ^-  marl
  ;*  %+  turn  (flop ids)
  |=  =ship
  ^-  manx
  ;div
    =client-display  "show-ids true"
    =class  "col-span-2 flex"
    ;div.px-4.py-2: {(scow %p ship)}
    ;form.px-4.py-2.ml-auto(event "/submit/remove-ship")
    =id  (scow %p ship)
      ;input.hidden(type "hidden", name "ship-input", value (scow %p ship));
      ;button: x
    ==
  ==
::
--

