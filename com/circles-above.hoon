/-  mast, *circles
/+  lucide, *helpers
^-  mast:mast
:-  :~  above+%circles-above
    ==
|_  =hull:mast
::
+*  get-chain  !<  (list (pair path post))  fil:(~(got by res.hull) %above)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ?+  route=((pole @ta) path.crow)  ~
    ::
      [%submit %post ~]
    ~
  ==
::
++  sail
  ^-  manx
  =/  chain  get-chain
  ;div
    ;*
    %+  turn  chain
    |=  [where=path =post]
    =/  href=tape
      %-  spud
      ?~  where  /circles
      /circles/[(rear where)]
    =/  id=tape
      =+  (scow %p (mug where))
      %+  welp  (swag [1 6] -)
      (slag 7 -)
    =/  [subject=tape body=wall]  (split-content content.post)
    ;div.flex.items-stretch
      ;+  (make-client-state:mast [[(crip id) "closed"]]~)
      ;button.font-mono.px-2.flex.flex-col.justify-start
        =client-display  "{id} closed"
        =client-event  "click {id} open"
        ; +
      ==
      ;button.font-mono.px-2.flex.flex-col.justify-start
        =client-display  "{id} !closed"
        =client-event  "click {id} closed"
        ; -
      ==
      ;div.flex.flex-col.grow
        ;a.flex.gap-2
          =href  href
          ;div.font-mono
            ;-  (cite:title author.post)
          ==
          ;div.text-neutral-bright:(-subject)
        ==
        ;div.whitespace-pre-line.py-4
          =client-display  "{id} !closed"
          ;*
          %+  turn  body
          |=  line=tape
          ;div:(-line)
        ==
      ==
    ==
  ==
--
