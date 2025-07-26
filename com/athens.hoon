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
  =/  fingerprint-to-id
    |=  fingerprint=cord
    ^-  @p
    (fil 5 3 (muk 'seed' (as-octs:mimes:html fingerprint)))
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
     [%input %set-access-mode ~]
    =/  mode  (~(got by data.crow) '/target/mode')
    :~  [%athens %athens-action !>([%set-access-mode mode])]
    ==
    ::
     [%submit %set-door-code ~]
    =/  code  (~(got by data.crow) 'code')
    :~  [%athens %athens-action !>([%gated-set-door-code code])]
    ==
    ::
      [%submit %sign-in ~]
    =/  fingerprint=@p
      %-  fingerprint-to-id
      (~(got by data.crow) 'fingerprint')
    ?.  ?=(^ (find ~[fingerprint] ~(val by accounts.access)))
      ~     :: fail sign-in if the user does not have an account
    :~  [%athens %athens-action !>(gated-sign-in+[src.hull fingerprint])]
    ==
    ::
      [%submit %register ~]
    =/  fingerprint=@p
      %-  fingerprint-to-id
      (~(got by data.crow) 'fingerprint')
    =/  door-code=@t  (~(got by data.crow) 'door-code')
    ?.  =(door-code door-code.access)
      ~
    :~  [%athens %athens-action !>(gated-sign-in+[src.hull fingerprint])]
    ==
    ::
      [%click %hide-all ~]
    :~  [%athens %athens-action !>([%hide-all ~])]
    ==
  ==
::
++  sail
  ^-  manx
  =/  access  get-access
  =/  authenticated-user=(unit @p)  (has-access src.hull access)
  =/  is-logged-in=?  |(?=(^ authenticated-user) =(our.hull src.hull))
  =/  user=@p  (fall authenticated-user src.hull)
  |^
    ;div.root
      ;+  (make-client-state:mast [reply+"~" edit+"~" show-settings+"false" show-ids+"false" loading-bundle+"~" ~])
      ;+
          ?:  |(=(our.hull src.hull) is-logged-in)
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
        ;+  ?:  !is-logged-in
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
          =class  "flex flex-col gap-2 w-auto max-w-[160px] md:w-[160px] menu"
          ;div
            =id  "menu-border"
            =onclick  "toggleView('settings-menu')"
            =class  "border border-[var(--grey-default)] hover:border-[var(--grey-light)] ".
                    "rounded bg-[var(--bg-color)] flex items-center ".
                    "justify-between gap-2 p-[8px] h-[28px] ".
                    "cursor-pointer patp justify-end md:justify-start" 
            ;urbit-sigil(patp (cite:title user));
            ;span(class "hidden md:block w-[16ch] m-0", id "patp"):  {(cite:title user)}
          == 
          ;div
            =id     "settings-menu"
            =class  "border border-[var(--grey-light)] rounded bg-[var(--bg-color)] hidden md:hover:flex w-[160px]"
            ;+  ?.  =(our.hull src.hull)  
                user-menu
              admin-menu
          ==
        ==
      ==
    ==
  ++  user-menu
    =/  button-wrapper-class  "flex items-center h-[28px] overflow-hidden"
    =/  button-class  "p-2 cursor-pointer col-span-2 flex items-center overflow-hidden text-[var(--grey-default)] hover:text-[var(--grey-light)]"
    ^-  manx
    ;div
      =class  "grid grid-rows-[repeat(auto-fit,28px)] ".
              "divide-y divide-[var(--grey-light)] leading-tight ".
              "max-h-[65vh] overflow-y-auto leading-[0.8] w-full"
      ;div
        =class  button-wrapper-class
        ;button
          =onclick  "toggleView('settings-menu')"
          =class  button-class
          =event  "/click/hide-all"
          ;  Read all
        ==
      ==
      ;div
        =class  button-wrapper-class
        ;a
          =class  button-class
          =href  "/~/logout?redirect=/mast/athens"
          ; Sign out
        ==
      ==
    ==
  ++  admin-menu
    ;div
      =class  "grid grid-cols-[auto_1fr] grid-rows-[repeat(auto-fit,28px)] ".
              "divide-y divide-[var(--grey-light)] leading-tight ".
              "max-h-[65vh] overflow-y-auto leading-[0.8] w-full"
      ;div
        =class  "flex items-center h-[28px] overflow-hidden"
        ;button
          =onclick  "toggleView('settings-menu')"
          =class  "p-2 cursor-pointer col-span-2 flex items-center overflow-hidden text-[var(--grey-default)] hover:text-[var(--grey-light)]"
          =event  "/click/hide-all"
          ;  Read all
        ==
      ==
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
                   "flex justify-between items-center text-[var(--grey-default)] hover:text-[var(--grey-light)]"
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
        =;  =marl  ?^  marl  marl
          ;=
            ;div.flex.flex-col.items-center
              ;div.text-lg.font-bold: Welcome to Circles.
              ;div: There are no posts yet.
            ==
          ==
        %+  turn  get-post-paths
        |=  =path
        %^  make:mast  mast/%athens-post
          :~
            :-  %fingerprint
              %+  scot  %p
              (~(gut by accounts.access) src.hull src.hull)
          ==
        :~  [%post (weld /athens/posts path)]
            [%view (welp /athens/view/[(scot %p user)] path)]
            [%new (weld /athens/new/[(scot %p user)] path)] 
            :: [%access /athens/access]
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
            ?:  !is-logged-in
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
    |^
      ?:  =(mode.access %gated)
        ?:  =('' door-code.access)
          ;div
            =class  "h-full w-full flex flex-col gap-5 ".
                    "items-center justify-center"
            ;div.font-bold: Unavailable
            ;div: The host needs to set the "door code" before you can register.
            ;a.underline
              =href  "/~/login?redirect=/mast/athens"
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
          ;script
            ;-  %-  trip
            '''
            function stringToUint8Array(str) {
              const encoder = new TextEncoder();
              return encoder.encode(str);
            }
            function arrayBufferToString(buffer, encoding = 'utf-8') {
              const decoder = new TextDecoder(encoding);
              const view = new Uint8Array(buffer);
              return decoder.decode(view);
            }
            function urbitChallenge() {
              return stringToUint8Array('urbit-deadbeef');
            }
            async function register(evt) {
              let credential = await navigator.credentials.create({
                publicKey: {
                  challenge: urbitChallenge(),
                  user: {
                    id: stringToUint8Array('athens'),
                    name: 'anonymous user',
                    displayName: 'anonymous user',
                  },
                  rp: { name: "Urbit" },
                  pubKeyCredParams: [{ type: "public-key", alg: -7 }],
                },
              });
              let fingerprint = credential.id
              document.getElementById('register-input').value = fingerprint;
              evt.target.closest('form').requestSubmit()
            }
            async function signIn(evt) {
              let credential = await navigator.credentials.get({
                publicKey: { challenge: urbitChallenge() }
              });
              let fingerprint = credential.id
              document.getElementById('sign-in-input').value = fingerprint;
              evt.target.closest('form').requestSubmit()
            }
            '''
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
        ;input.hidden(name "redirect", value "/mast/athens");
        ;div.flex.flex-col.gap-3.border.rounded-md.p-3.border-neutral-800
          ;div.text-red-400: access denied
          ;+
          ?:  !is-logged-in  ;/("")
          ;div.flex.gap-2
            ;div.font-mono: {(cite:title user)}
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
  --
::
--
|%
::
++  has-access
  |=  [=ship =access:athens]
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
::
++  toggle
  ^-  marl
  ;=
    ;div(class "w-[20px] h-[11px] bg-[var(--grey-light)] rounded-full transition-colors");
    ;div(class "absolute left-[0] top-[0] w-[9px] h-[9px] bg-[var(--bg-color)] rounded-full transition-transform transform peer-checked:translate-x-full m-[1px]");
  ==
::
++  edit-access-form
  |=  mode=access-mode:athens
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
::
++  id-list
  |=  ids=(list @p)
  ^-  marl
  ;*  %+  turn  ids
  |=  =ship
  ^-  manx
  ;div
    =class  "col-span-2 flex gap-auto text-[var(--grey-default)] hover:*:text-[var(--grey-light)]"
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
::
--