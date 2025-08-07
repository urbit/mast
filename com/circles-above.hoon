/-  mast, *circles
/+  lucide, *helpers
^-  mast:mast
:-  :~  above+%circles-above
        replies+%noun
    ==
|_  =hull:mast
::
+*  get-chain  !<  (list (pair path post))  fil:(~(got by res.hull) %above)
    get-replies  !<  @ud  fil:(~(got by res.hull) %replies)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ?+  route=((pole @ta) path.crow)  ~
    ::
      [%submit %edit ~]
    =/  where=path  (stab (~(got by data.crow) 'where'))
    =/  content=@t  (~(got by data.crow) 'content')
    :~  [%circles-action !>([%edit-post where content])]
    ==
    ::
      [%click %delete where=*]
    :~  [%circles-action !>([%delete-post where.route])]
    ==
  ==
::
++  sail
  ^-  manx
  =/  chain  get-chain
  ;div
    ;*
    =|  acc=marl
    |-
    ^+  acc
    ?~  chain  (flop acc)
    =/  [where=path =post]  i.chain
    =/  href=tape
      %-  spud
      ?~  where  /circles
      /circles/[(rear where)]
    =/  id=tape
      =+  (scow %p (mug where))
      %+  welp  (swag [1 6] -)
      (slag 7 -)
    =/  [subject=tape body=wall]  (split-content content.post)
    =/  modifyable=?
      ?&
        ?=(~ t.chain)
        ?|
          =(author.post src.hull)
          =(our.hull src.hull)
        ==
      ==
    =;  =manx  $(acc [manx acc], chain t.chain)
    ;div.flex.items-stretch
      ;+  %-  make-client-state:mast
          :~
            [(crip id) ?~(t.chain "open" "closed")]
            [(crip (welp "editing" id)) "false"]
          ==
      ;*
        =/  class
          %+  welp  "hover font-mono px-2 flex flex-col justify-start ".
                    "text-neutral-bright disabled:text-neutral-disabled "
          ?~  where
            ?~  t.chain  ""
            "center-line-first"
          ?~  t.chain  "center-line-last"
          "center-line"
      ;=
        ;+
          %^  attr-if  ?=(~ body)  disabled+""
          %^  attr-if  ?=(~ t.chain)  hidden+""
        ;button
          =class  class
          =client-display  "{id} closed"
          =client-event  "click {id} open"
          ; -
        ==
        ;+
          %^  attr-if  ?=(~ body)  disabled+""
          %^  attr-if  ?=(^ t.chain)  hidden+""
        ;button
          =class  class
          =client-display  "{id} !closed"
          =client-event  "click {id} closed"
          ; •
        ==
      ==
      ;div.flex.flex-col.grow
        ;a
          =href  href
          ;span.text-neutral-bright:(-subject)
          ;*  ?~  where  ~
            ;=
              ;span.opacity-0:(-" . ")
              ;span.text-sm.font-mono
                ;-  (cite:title author.post)
              ==
            ==
        ==
        ;*  ?:  ?&  ?=(^ t.chain)
                    ?=(~ body)
                ==
              ~
        :_  ~
          %^  attr-if  ?=(^ t.chain)  hidden+""
        ;div.py-4.flex.flex-col.gap-4
          =client-display  "{id} !closed"
          ;*  ?.  modifyable  ~
              :_  ~
              ;form
                =class  "relative.border rounded-sm flex items-stretch h-[28px]"
                =client-display  "editing{id} true"
                =event  "/submit/edit"
                =onsubmit  "clientState['editing{id}'] = 'false'; handleClientAttrs(document.body);"
                =hidden  ""
                ;input.hidden(name "where", value (spud where));
                ;expanding-textarea.py-1.px-2.grow.text-neutral-bright
                  =placeholder  "reply"
                  =name  "content"
                  =required  ""
                  ;*
                  %+  turn  `wall`[subject "" body]
                  |=  line=tape
                  ;/  (welp line "\0a")
                ==
                ;button.hover.p-1.flex.flex-col.justify-end: →
              ==
          ;div.whitespace-pre-line.pl-4.text-neutral-bright
            =client-display  "editing{id} !true"
            ;*
            %+  turn  body
            |=  line=tape
            ;div:(-line)
          ==
          ;*
          ?.  modifyable
            ~
          :_  ~
          ;div.flex.gap-3.pl-4
            ;button.hover
              =client-event  "click editing{id} true"
              =client-display  "editing{id} false"
              ; edit
            ==
            ;button.text-neutral-bright.hover
              =client-event  "click editing{id} false"
              =client-display  "editing{id} true"
              =hidden  ""
              ; edit
            ==
            ;+ 
            =/  to
              ?:  (gth (lent get-chain) 2)
                "./{(trip (rear `(list @tas)`p:(snag 1 (flop get-chain))))}"
              "./"
            ;button
              =event  "/click/delete{(spud where)}"
              =onclick  "window.location.href = '{to}';"
              ; delete
            ==
            ;div
              ; replies: {<get-replies>}  
            ==
          ==
        ==
      ==
    ==
  ==
--
