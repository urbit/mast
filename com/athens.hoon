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
                "gradient-top z-50 pointer-events-none"
        ;
      ==
      ;div
        =class  "user fixed z-100"
        ;+  ?:  is-comet  
              public-login-form
            header-menu
      ==
      ;div
        =class  "gradient-bottom fixed bottom-0 left-0 w-full ".
                "h-[18vh] md:h-[9vh] z-25 pointer-events-none"
        ;
      ==
      ;+  list-posts
    ==
  ++  header-menu
  ;div
    ;div
      ;div
        =class  "flex flex-col gap-2 w-auto md:w-[160px] menu"
        ;div
          =onclick  "toggleView('settings-menu')"
          =class  "border border-[var(--grey-default)] hover:border-[var(--grey-light)] ".
                  "rounded bg-[var(--bg-color)] flex items-center ".
                  "justify-between gap-2 p-[8px] h-[28px] ".
                  "cursor-pointer patp justify-end md:justify-start" 
          ;urbit-sigil(patp (cite:title src.hull));
          ;span(class "hidden md:block w-[16ch] m-0"):  {(cite:title src.hull)}
        == 
        ;div
          =id     "settings-menu"
          =class  "border border-[var(--grey-light)] rounded bg-[var(--bg-color)] hidden md:hover:flex w-[158px]"
            ;+  ?.  =(our.hull src.hull)  
                user-menu
              admin-menu
        ==
      ==
    ==
  ==
  ++  user-menu
    ;div
      =class  "flex justify-center items-center h-[28px]"
      =style  "overflow-y: auto;"
      ;a.px-2.py-2.cursor-pointer.col-span-2.flex.justify-center.items-center
        =href  "/~/logout?redirect=/mast/athens"
        ; Sign out
      ==
    ==
  ++  admin-menu
    ;div
      =class  "grid grid-cols-[auto_1fr] grid-rows-[repeat(auto-fit,28px)] ".
              "divide-y divide-[var(--grey-light)] leading-tight ".
              "max-h-[400px] overflow-y-auto leading-[0.8]"
      ;div(class "mt-auto p-2 h-[28px] flex items-center justify-center")
        ; Public
      ==
      ;label.p-2.w-full.flex.items-center.justify-end.relative
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
      ;+
      ;div
        =class  "p-2 cursor-pointer col-span-2 ".
                "flex justify-between items-center"
        =onclick  "toggleClassView('show-ids')"
        ;span: {?:(public.access "Blocked" "Members")}
        ;div.show-ids
            ;+  vector-out:lucide
          ==
        ;div(class "show-ids hidden md:hidden")
            ;+  vector-in:lucide
        ==
      ==
      ;+  (edit-access-form public.access)
      ;*  
      ?:  public.access
        (id-list blacklist.access)
      (id-list members.access)
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
      ;div(class "fixed bottom-[24px] inset-x-0 z-50 md:w-full")
        =key  "athens-post-form" 
        ;div
          =id     "form-post-wrapper" 
          =class  "form-post-wrapper md:grid md:grid-rows-[min-content] md:grid-cols-3 ".
                  "md:items-start md:items-start md:grid-cols-[15ch_auto_120px] mx-4 ".
                  "md:gap-x-4 mx-auto max-w-[1000px]"
          =client-display  "edit ~"
          ;+  
            ?:  is-comet
              ;div.post-form.login-block: Login to post
            ;div
              =class  "mx-4 md:col-start-2 ".
                      "form-border rounded-md shadow-md ". 
                      "bg-[var(--bg-color)] focus-within:!border-white ". 
                      "focus-within:!text-white"
              ;form(event "/submit/post")
                =id     "post-form"
                =class  "post-form rounded-md shadow-md ".
                        "overflow-hidden box-border flex items-stretch ".
                        "md:rounded-none md:shadow-none md:p-0 ".
                        "items-stretch [&.is-focused]:!border-white [&.is-focused]:!text-white" 
                ;athens-textarea-litdev.grow
                  =name  "post-input"
                  ;
                ==
                ;button
                  =class  "mt-auto p-2 text-[14px] h-[28px] flex items-center justify-center"
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
    ;div(class "w-[20px] h-[11px] bg-[var(--grey-light)] rounded-full transition-colors");
    ;div(class "absolute left-[0] top-[0] w-[9px] h-[9px] bg-[var(--bg-color)] rounded-full transition-transform transform peer-checked:translate-x-full m-[1px]");
  ==
::
++  edit-access-form
  |=  public=?
  ^-  manx
  ;form(event "/submit/add-ship")
    =class  "col-span-2 px-2 w-full flex gap-2 h-[28px]"
    ;+  ?:  public
      ;button.ml-auto.cursor-pointer: ~
    ;button.ml-auto.cursor-pointer: +
    ;input(type "text", name "ship-input")
      =class  "border-0 focus:outline-none text-white w-full leading-tight"
    ;
    ==
  ==
::
++  id-list
  |=  ids=(list @p)
  ^-  marl
  ;*  %+  turn  (flop ids)
  |=  =ship
  ^-  manx
  ;div
    =class  "show-ids hidden md:hidden col-span-2 flex gap-auto"
    ;div(class "mt-auto p-2 h-[28px] flex items-center justify-center"): {(scow %p ship)}
    ;form(event "/submit/remove-ship", class "ml-auto mt-auto p-2 h-[28px] flex items-center justify-center")
    =id  (scow %p ship)
      ;input.hidden(type "hidden", name "ship-input", value (scow %p ship));
      ;button(class "cursor-pointer"): x
    ==
  ==
::
--
