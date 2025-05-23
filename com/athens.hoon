/-  mast, athens
/*  athens-textarea-litdev  %js  /fil/athens-textarea-litdev/js
/*  footnote-parser  %js  /fil/footnote-parser/js
:-  ^-  boom:mast
    :*  %athens-access
        %z
        !>(|^|^~)
    ==
=<
^-  mast:mast
|_  [=scud:mast =sack:mast]
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  =/  pol  ^-  (pole @ta)  path.crow
  =/  loc  !<  [settings=? show-ids=? show-del=(unit @p)]  loc.sack
  ?+  pol  ~^~
    ::
      [%submit %post ~]
    =/  dat  (~(got by data.crow) 'post-input')
    ?:  =('' dat)  ~^~
    :_  !>  loc
    :~  [%athens %athens-action !>([%put-post ~ dat])]
    ==
    ::
      [%mouseenter %show-settings ~]
    ?:  settings.loc  ~^~
    ?.  =(our.scud yon.scud)  ~^~
    :_   !>  loc(settings !settings.loc)
    ~
    ::
      [%mouseleave %show-settings ~]
    ?.  settings.loc  ~^~
    :_   !>  loc(settings !settings.loc)
    ~
    ::
      [%change %toggle-private ~]
    =/  access  !<  access:athens  fil.sack
    :_  !>  loc
    :~  [%athens %athens-action !>([%access-public !public.access])]
    ==
    ::
      [%click %toggle-show-ids ~]
    =/  access  !<  access:athens  fil.sack
    :_  !>  loc(show-ids !show-ids.loc)
    ~
    ::
      [%submit %remove-ship ~]
    =/  dat  (~(got by data.crow) 'ship-input')
    ?:  =('' dat)  ~^~
    :_  !>  loc
    :~  [%athens %athens-action !>([%del-access-id (slav %p dat)])]
    ==
    ::
      [%submit %add-ship ~]
    =/  dat  (~(got by data.crow) 'ship-input')
    ?:  =('' dat)  ~^~
    :_  !>  loc
    :~  [%athens %athens-action !>([%edit-access-id [`@p`(slav %p dat)]~])]
    ==
    ::
      [%mouseenter %show-del * ~]
    =/  u-ship=(unit ship)  (slaw %p -.+.+.pol)
    :_  !>  loc(show-del u-ship)
    ~
    ::
      [%mouseleave %show-del ~]
    :_  !>  loc(show-del ~)
    ~
    ::
  ==
::
++  sail
  ^-  manx
  =/  loc  !<  [settings=? show-ids=? show-del=(unit @p)]  loc.sack
  =/  is-comet=?  ?=(%pawn (clan:title yon.scud))
  =/  access  !<  access:athens  fil.sack
    ;html
      ;head
        ;title: Athens
        ;meta(charset "UTF-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
        ;script(src "https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4");
        ;script(src "https://cdn.jsdelivr.net/npm/marked/marked.min.js");
        ;script(type "module"): {(trip footnote-parser)}
        ;script(type "module"): {(trip athens-textarea-litdev)} 
        ;style(type "text/tailwindcss")
          ;-  %-  trip
          '''
          @theme {
            --color-neutral-bg: #0f0f0f;
            --color-neutral-400: #A3A3A3;
          }
          '''
        ==
      ==
      ;body
        ;+  ?.  |(=(our.scud yon.scud) (has-access yon.scud access))
          ;div
          =class  "bg-neutral-bg text-neutral-400 athens h-full"
            ; No access 
          ==
        ;div
          =class  "bg-neutral-bg text-neutral-400 athens"
          ;div
            =class  "relative h-[112px] w-full"
            ;div
              =class  "fixed top-0 left-0 w-full h-[18vh] bg-gradient-to-b from-black/100 to-transparent z-50 pointer-events-none md:hidden"
              ;
            ==
            ;div
              =class  "user fixed z-100"
              ;+  ?.  is-comet
                    ;div(event "/mouseenter/show-settings /mouseleave/show-settings")
                      =class  "border border-[#A3A3A3] rounded bg-[#0F0F0F]"
                      ;div
                      =class  "flex flex-row px-4 py-2 {?.(settings.loc "" "hidden")}"
                        ;  {(cite:title yon.scud)}
                      == 
                      ;*  ?:  =(our.scud yon.scud)
                        ;=
                          ;div
                          =class  "grid grid-cols-[auto_1fr] divide-y divide-[#A3A3A3] {?.(settings.loc "hidden" "")}"
                          ::"hidden sm:grid")}"
                            ;div.px-4.py-2: Urbit ID
                            ;div.px-4.py-2
                              ; {(cite:title yon.scud)}
                            ==
                            ;div.px-4.py-2
                              ; Public Access
                            ==
                            ;label.px-4.py-2.w-full.flex.items-center.justify-end.relative
                              ;div.relative.inline-block
                                ;+  ?.  public.access
                                  ;input.sr-only.peer(type "checkbox", event "/change/toggle-private", name "toggle-access", checked "")
                                    ;*  toggle
                                  ==
                                ;input.sr-only.peer(type "checkbox", event "/change/toggle-private", name "toggle-access")
                                  ;*  toggle
                                ==
                              ==
                            ==
                            ;*  ?.  public.access
                              ;=
                                ;div.px-4.py-2.cursor-pointer(event "/click/toggle-show-ids"): Blocked
                                ;+  ?:  show-ids.loc
                                  ;div.px-4.py-2.w-full.flex.justify-end.relative.cursor-pointer(event "/click/toggle-show-ids"):  <
                                ;div.px-4.py-2.w-full.flex.justify-end.relative.cursor-pointer(event "/click/toggle-show-ids"):  >
                                ;+  (edit-access-form public.access)
                                ;*  ?:  show-ids.loc
                                  (id-list blacklist.access show-del.loc)
                                ~
                              ==
                            ;=
                              ;div.px-4.py-2.cursor-pointer(event "/click/toggle-show-ids"): Members
                              ;+  ?:  show-ids.loc
                                ;div.px-4.py-2.w-full.flex.justify-end.relative.cursor-pointer(event "/click/toggle-show-ids"):  <
                              ;div.px-4.py-2.w-full.flex.justify-end.relative.cursor-pointer(event "/click/toggle-show-ids"):  >
                              ;+  (edit-access-form public.access)
                              ;*  ?:  show-ids.loc
                                (id-list members.access show-del.loc)
                              ~
                            ==
                          ==
                          ::;+  (mobile-view-user loc scud access)
                        ==
                      ~
                    ==
                  ;form.flex
                    =action  "/~/login"
                    =method  "POST"
                    ;label.p-2(for "login-input"): login:
                    ;input(id "login-input", name "name", required "");
                    ;input(type "hidden", name "redirect", value (spud ;:(weld /mast pax.scud /athens)));
                    ;input(type "hidden", name "eauth", value "");
                    ;button(type "submit")
                      ;i(data-lucide "arrow-right");
                    ==
                  ==
            ==
            ;div
              =class  "gradient fixed bottom-0 left-0 w-full h-[18vh] bg-gradient-to-t from-black/100 to-transparent z-50 pointer-events-none md:hidden"
              ;
            ==
          ==
          ;div;
          ;div
            =class  "posts md:gap-[32px] gap-[16px]"
            ;+  style
            ;*  %+  turn  kid.scud
                |=  p=path
                (make:mast %athens-post (weld pax.scud p) ~)
            ;+  ?:  is-comet
                  ;div.post-form.login-block: Login to post
                ;form(event "/submit/post")
                  =class  "post-form fixed bottom-4 inset-x-4 z-50 rounded-md shadow md:w-full md:static md:inset-auto md:rounded-none md:shadow-none md:p-0"
                  =key  "athens-post-form"
                  ;athens-textarea-litdev(class "w-full min-h-[28px] resize-none overflow-auto md:overflow-hidden box-border p-[11px]", textareaClass "overflow-auto md:overflow-hidden box-border", name "post-input");
                  ;button.mt-auto.p-2: ↵
                ==
          ==
      ==
    ==
    ;script(src "https://unpkg.com/lucide@latest");
    ;script:  lucide.createIcons();
  ==
::
--
|%
::
++  has-access
  |=  [=ship =access:athens]
  ^-  ?
  ?.  public.access 
    ?.  =(~ (find [ship]~ members.access))  |  &
  ?.  =(~ (find [ship]~ blacklist.access))  &  |
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
  |=  [ids=(list @p) show-del=(unit @p)]
  ^-  marl
  ;*  %+  turn  (flop ids)
  |=  =ship
  ^-  manx
  ;div(event "/mouseleave/show-del /mouseenter/show-del/{(scow %p ship)}")
    =class  "col-span-2 flex"
    ;div.px-4.py-2: {(scow %p ship)}
    ;+  ?:  =(show-del `ship)
        ;form.px-4.py-2.ml-auto(event "/submit/remove-ship")
        =id  (scow %p ship)
          ;input.hidden(type "hidden", name "ship-input", value (scow %p ship));
          ;button: x
        ==
      ;div;
  ==
::
++  style
  ^-  manx
  ;style
    ;-  %-  trip
    '''
    body{
      overflow-x: hidden;
    }
    .options {
      color: #A3A3A3;
    }
    .options > button {
      color: #A3A3A3;
      margin-inline: 0.25em;
      font-family: Inter, sans-serif;
      font-size: 0.85rem;
    }
    .post-container:hover > .options{
      visibility: visible;
    }
    .options > button:hover {
      color: #FAFAFA;
    }
    .login-link {
      margin-right: 0.2em;
      color: #FAFAFA;
    }
    .user {
      top: 15;
      right: 30;
      padding-block: 0.2em;
      padding-inline: 0.3em;
      color: #A3A3A3;
      font-weight: 500;
      font-size: 14px;
    }
    .user.open{
      left: 15;
      width: 100%;
    }
    .athens {
      height: 100%;
      width: 100%;
      /* background: #0f0f0f; */
      overflow-y: scroll;
    }
    .posts {
      padding: 150px 16px 400px 16px;
      margin: auto;
      width: 100%;
      max-width: 1000px;
      display: flex;
      flex-direction: column;
    }
    .author {
      font-family: 'Source Code Pro', monospace;
      font-weight: 500;
      font-size: 14px;
      leading-trim: Cap height;
      line-height: 140%;
      letter-spacing: 0%;
      vertical-align: middle;
      color: #FAFAFA;
    }
    .author.hide {
      color: #737373;
    }
    .message {
      font-family: Inter, sans-serif;
      font-weight: 400;
      font-size: 14px;
      leading-trim: Cap height;
      line-height: 130%;
      letter-spacing: 0%;
      color: #A3A3A3;
      max-width: 645px;
    }
    .message.hide {
      color: #737373;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .message.reply {
      padding-left: 0.3em;
      border-left-width: 1px;
      border-left-color: #575757;
      border-left-style: solid;
    }
    .replies-container {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }
    .replies {
      padding-left: 0px;
    }
    .reply-num{
      color: #737373;
      font-size: 14px;
    }
    .reply-num.full{
      display: none;
    }
    .reply-num.hide{
      display: flex;
    }
    .reply-date.full{
      display: none;
    }
    .reply-date.hide{
      display: flex;
      color: #737373;
      font-size: 14px;
    }
    .post-form {
      background: #0f0f0f;
      margin-top: 0.45em;
      padding: 0.15em;
      border: solid;
      border-width: 1px;
      border-radius: 6px;
      border-color: #575757;
      display: flex;
    }
    .post-form.login-block {
      -webkit-user-select: none;
      -ms-user-select: none;
      user-select: none;
      justify-content: center;
      font-family: Inter, sans-serif;
      font-size: 0.85rem;
    }
    .post-form > textarea {
      color: #FAFAFA;
      height: 1.5em;
      min-height: 1.5em;
      padding-inline: 0.3em;
      padding-top: 0.1em;
      resize: block;
      flex-grow: 1;
      font-size: 0.85rem;
      font-family: Inter, sans-serif;
    }
    .post-form > button {
      padding-inline: 0.2em;
      color: #A3A3A3;
    }
    .post-form > button:hover {
      color: #FAFAFA;
    }
    .post-reply-form {
      border: solid;
      border-width: 1px;
      border-radius: 6px;
      border-color: #575757;
      display: flex;
      gap: 8px;
    }
    .reply-button:hover{
      padding: 0.15em;
      border: solid;
      border-width: 1px;
      border-radius: 6px;
      border-color: #2C2C2C;
      background-color: #2C2C2C;
    }
    athens-textarea-litdev .tab-controls {
      display: flex;
    }
    athens-textarea-litdev .tab {
      padding: 8px 16px;
      font-size: 14px;
      border: none;
      background: none;
      cursor: pointer;
      outline: none;
    }
    athens-textarea-litdev .tab.active {
      background: #262626;
    }
    athens-textarea-litdev textarea {
      width: 100%;
      resize: none;
      font-size: 14px;
      border: none;
      box-sizing: border-box;
      font-family: inherit;
    }
    athens-textarea-litdev .markdown-preview {
      font-size: 14px;
    }
    athens-textarea-litdev .clamp-one-line {
      display: -webkit-box;
      -webkit-line-clamp: 1;
      -webkit-box-orient: vertical;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: normal;
      :: max-width: 400px;
    }
    athens-textarea-litdev textarea{
      background: #0f0f0f;
    }
    athens-textarea-litdev .clamp-one-line h1,
    athens-textarea-litdev .clamp-one-line h2,
    athens-textarea-litdev .clamp-one-line h3,
    athens-textarea-litdev .clamp-one-line h4,
    athens-textarea-litdev .clamp-one-line h5,
    athens-textarea-litdev .clamp-one-line h6 {
      font-size: 14px;
      font-weight: 400;
      line-height: 1.5;
    }
    athens-textarea-litdev .clamp-one-line table {
      font-size: 14px;
      font-weight: 400;
      line-height: 1.5;
      display: inline;
      border: none;
    }
    athens-textarea-litdev .clamp-one-line pre {
      font-size: 14px;
      font-weight: 400;
      line-height: 1.5;
      display: inline;
      border: none;
      color: #737373;
    }
    athens-textarea-litdev .clamp-one-line tbody {
      display: none;
    }
    .prose.clamp-one-line td, 
    athens-textarea-litdev .prose.clamp-one-line th {
      display: inline;
      padding: 0;
      background: none;
      border: none;
      color: #737373;
    }
    athens-textarea-litdev h1 {
      font-size: 48px;
      letter-spacing: 0.01em;
      line-height: 1.1;
      translate: 0 calc(2px* -3);
    }
    athens-textarea-litdev h2 {
      font-size: 30px;
      line-height: 1.2;
      translate: 0 calc(2px* -2);
    }
    athens-textarea-litdev h3 {
      font-size: 24px;
      line-height: 1.2;
      translate: 0 calc(2px* -2);
    }
    athens-textarea-litdev h4 {
      font-size: 20px;
      translate: 0 calc(2px* -2);
    }
    athens-textarea-litdev h5 {
      font-size: 18px;
      translate: 0 calc(2px* -2);
    }
    athens-textarea-litdev h6 {
      font-size: 14px;
      translate: 0 calc(2px* -2);
    }
    .prose ul {
      list-style-type: disc;
      padding-left: 1.5rem; /* match Tailwind's pl-6 */
    }
    .prose ol {
      list-style-type: decimal;
      padding-left: 1.5rem;
    }
    .prose code {
      background-color: #f3f4f6; /* Tailwind's bg-gray-100 */
      padding: 0.125rem 0.25rem; /* px-1 py-0.5 */
      border-radius: 0.25rem; /* rounded */
      font-size: 0.875em;
    }  
    .prose pre {
      /* background-color: #737373; */
      color: #FAFAFA;
      padding: 1rem; /* p-4 */
      border-radius: 0.5rem; /* rounded-lg */
      overflow-x: auto;
    }
    .prose pre code {
      background: transparent;
      padding: 0;
    }
    .prose table {
      font-family: Inter, sans-serif;
      border: 1px solid #A3A3A3;
      border-radius: 0.5rem;
      margin-top: 8px;
      margin-bottom: 8px;
    }
    .prose th {
      text-align: left;
      font-family: Inter, sans-serif;
      font-weight: normal;
      padding: 16px;
      color: #A3A3A3;
      border-bottom: 1px solid #A3A3A3;
    }
    .prose td {
      font-family: Inter, sans-serif;
      padding: 16px;
      color: #FAFAFA;
      border-bottom: 1px solid #A3A3A3;
    }
    .prose tr:last-child td {
      border-bottom: none;
    }
    .prose sup.footnote {
      font-size: 0.75em;
      color: #A3A3A3;
    }
    .prose a {
      text-decoration: underline;
    }
    .grid > div:nth-last-child(-n+3) {
      margin-bottom: 0; /* Remove bottom margin for last item */
    }
    @media (min-width: 768px) {
      .author {
        margin-left: 0 !important;
      }
      :: .message.reply {
      ::   border-left-width: 0 !important;
      ::   border-left-style: none !important;
      :: }
    }
    '''
  ==
::
--

