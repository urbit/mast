/-  mast, *circles
/+  lucide
/+  *helpers
^-  mast:mast
:-  :~  access+%circles-access
    ==
|_  =hull:mast
::
+*  get-access  !<  access  fil:(~(got by res.hull) %access)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  =/  access  get-access
  ?+  route=((pole @ta) path.crow)  ~
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
++  sail
  ^-  manx
  =/  access  get-access
  |^
    ;div.p-4.flex.flex-col.gap-4.border.rounded-sm
      ;+  admin-menu
    ==
  ++  admin-menu
    ;div
      =class  "grid grid-cols-[auto_1fr] grid-rows-[repeat(auto-fit,28px)] ".
              "divide-y divide-[var(--color-neutral-dim)] leading-tight ".
              "max-h-[65vh] overflow-y-auto leading-[0.8] w-full"
      ;+  (make-client-state:mast [show-ids+"false"]~)
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
    |=  mode=access-mode
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
  --
--