/-  mast, athens
^-  mast:mast
:-  :~  %auth
        post+%athens-post
        hidden+%noun
    ==
=<
|_  =hull:mast
::
+*  post  (~(got by res.hull) %post)
    is-hidden  %-  ?  !<  *  fil:(~(got by res.hull) %hidden)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  =/  hid  is-hidden
  =/  paf  src:post
  ?>  ?=([%athens %posts *] paf)
  ?+  path.crow  ~
    ::
      [%click %toggle-hide ~]
    =/  id  (slav %da (rear src:post))
    ?:  hid
      :~  [%athens %athens-action !>([%unhide-post id])]
      ==
    :~  [%athens %athens-action !>([%hide-post id])]
    ==
    ::
      [%submit %reply ~]
    =/  dat  (~(got by data.crow) 'reply-input')
    ?:  =('' dat)  ~
    :~  [%athens %athens-action !>([%put-post t.t.paf dat])]
    ==
    ::
      [%submit %edit ~]
    =/  dat  (~(got by data.crow) 'edit-input')
    ?:  =('' dat)  ~
    :~  [%athens %athens-action !>([%patch-post t.t.paf dat])]
    ==
    ::
      [%click %delete ~]
    :~  [%athens %athens-action !>([%del-post t.t.paf])]
    ==
    ::
  ==
::
++  sail
  ^-  manx
  =/  src  (need src.hull)
  =/  hid  is-hidden
  =/  [paf=path dat=post-view:athens]  =+(post [src !<(post-view:athens fil)])
  =/  idt  (trip (rear paf))
  ::=/  content-wall  (parse-content (trip content.dat))
  =/  num-lines  (lent (to-wain:format content.dat))
  =/  sticky  ?:((gth num-lines 8) "md:sticky" "")
  =/  is-comet=?  ?=(%pawn (clan:title src))
  =/  reply=?
    ?>  ?=([%athens %posts *] paf) 
    (gth (lent t.t.paf) 1) 
  =/  depth=@
    =-  (mul (dec -) 8)
    ?>  ?=([%athens %posts *] paf)
    ?:  (gth (lent t.t.paf) 2) 
      (dec (lent t.t.paf))  
    1
  ;div
    =class  "post-node-container flex flex-col md:gap-[16px] gap-[16px]"
    :: ;+  ?.  reply  ;div;
      :: ;div(class "border-left absolute w-px bg-[#737373] z-0 top-0 bottom-[5px]", style "--depth: {((d-co:co 1) depth)}px;");
    ;div
      =class  "post-container relative grid grid-cols-2 ".
              "grid-rows-[min-content] gap-y-[16px] md:gap-x-4 ".
              "md:pb-[0px] w-full md:grid-cols-3 md:flex-row ".
              "md:items-start md:w-full md:grid-cols-[min-content_auto_120px] z-10" 
      :: ;div
      ::   =class  "pointer col-start-1 row-start-1 md:flex max-w-[16ch]"
        ;div(event "/click/toggle-hide")
          =class  "author {?:(hid "hide" "")} {sticky} ".
                  "top-20 cursor-pointer w-[15ch] max-w-[15ch] ".
                  "ml-[{((d-co:co 1) depth)}px] overflow-hidden ".
                  "whitespace-nowrap flex items-start col-start-1 ".
                  "row-start-1 md:text-right {?.(reply "" "pl-2")} md:pl-0"
          ;span(class "inline-block leading-none align-top w-full"): {(cite:title author.dat)}
        ==
      ::==
      ;+  
        =/  depth=@
          =-  (mul (dec -) 8)
          ?>  ?=([%athens %posts *] paf)
          ?:  (gth (lent t.t.paf) 2) 
            (dec (lent t.t.paf))  
          1
        ;div
          =class  "message {?:(hid "hide md:w-[50%] w-[85%]" "full")} ".
                  "{?.(reply "" "reply")} col-span-2 md:col-start-2 ".
                  "md:col-span-1 row-start-2 md:row-start-1 flex flex-col ".
                  "gap-[8px] md:gap-[16px] md:flex-grow ml-[{((d-co:co 1) depth)}px] ".
                  "border-l-0" 
          ;form
            =name   "edit-form"
            =event  "/submit/edit"
            =client-event  "submit edit ~"
            =client-display  "edit {idt}"
            =class  "post-reply-form w-full min-h-[16px] ".
                    "resize-none overflow-hidden box-border ".
                    "form-border flex items-stretch justify-between gap-0 ".
                    "[&.is-focused]:!border-white [&.is-focused]:!text-white"
            ;athens-textarea-litdev(value (trip content.dat), class "grow {?:(hid "hide" "")}", name "edit-input");
            ;button
              =event  "/click/toggle-edit"
              =class  "mt-auto p-2 text-[14px]"
              ;span: →
            ==
          ==
          ;athens-textarea-litdev(name "preview-only", value (trip content.dat), preview-only "true") 
            =client-display  "edit !{idt}"
            =class  "w-full resize-none overflow-hidden box-border text-sm {?:(hid "hide" "")}"
            ;*  ~
          ==
          ;+  ?:  hid
              ;div.hidden;
            ;form
              =name   "reply-form"
              =event  "/submit/reply"
              =client-event  "submit reply ~"
              =client-display  "reply {idt}"
              =class  "post-reply-form form-border flex ".
                      "items-stretch [&.is-focused]:!border-white [&.is-focused]:!text-white"
              ;athens-textarea-litdev(class "grow", name "reply-input"); 
              ;button 
                =type  "submit"
                =class  "mt-auto p-2 text-[14px]"
                ;span: →
              ==
            ==
        ==
      ;div
        =class  "md:col-start-2 md:row-start-1 flex flex-row justify-end {?:(hid "" "hidden")}"
        ;+  ?:  =(0 (lent replies.dat))
            ;div.hidden;
          ;div
            =class  "reply-num {?:(hid "hide" "full")} pr-4 text-[{txt-color}]"
            ;p.inline.whitespace-nowrap.w-auto.inline-block.leading-none.align-top: {<(lent replies.dat)>} {?:(=(1 (lent replies.dat)) " reply" " replies")}
          ==
        ;div
          =class  "reply-date {?:(hid "hide" "full")} inline whitespace-nowrap w-auto text-[{txt-color}] inline-block leading-none align-top"
          {(date-to-tape (slav %da (rear paf)) now.hull)}
        ==
      ==
      ;+  ?:  is-comet
            ;div.hidden;
          ;div
            =class  "options {sticky} top-20 col-start-2 ".
                    "row-start-1 md:col-start-3 md:row-start-1 ".
                    "flex gap-2 justify-end md:invisible visible ".
                    "color-[#646464] {?:(hid "hidden" "")} ".
                    "leading-none align-top md:justify-start"
            ;button(client-display "reply !{idt}", client-event "click reply {idt}"): reply
            ;button(client-display "reply {idt}", client-event "click reply ~"): reply
            ;*  ?:  =(author.dat src)
              ;=
                ;button(client-display "edit !{idt}", client-event "click edit {idt}"): edit
                ;button(client-display "edit {idt}", client-event "click edit ~"): edit
                ;button(event "/click/delete"): delete
              ==
            ~
          ==
    ==
    ;+  ?:  ?|  hid
                ?=(~ replies.dat)
            ==
          ;div.hidden;
        =/  depth=@
          =-  (mul (dec -) 8)
          ?>  ?=([%athens %posts *] paf)
            (lent t.t.paf)  
        ;div.replies-container.z-10.relative
          ;div(class "border-left absolute w-px bg-[#737373] z-0 top-0 bottom-[5px]", style "--depth: {((d-co:co 1) depth)}px;");
          ;*  %+  turn  replies.dat
              |=  p=path
              %^  make:mast  mast/%athens-post  ~
              :~  [%post (weld paf p)] 
                  [%hidden /athens/hidden/[(scot %p src)]/[(rear p)]]
              ==
        ==
  ==
::
--
|%
::
++  txt-color  "#737373"
::
++  parse-content
  |=  tap=tape
  =/  index  0  
  =/  result  *(list tape)  
  |-  ^-  (list tape)  
  =/  sca  `tape`(scag index tap)
  ?:  =(index (lent tap))  
    (weld result ~[sca])
  ?:  =((snag index tap) ' ') 
    $(index 0, tap `tape`(slag +(index) tap), result (weld result ~[sca]))
  ?.  =(+(index) (lent tap))   
    $(index +(index))
  $(index +(index))
::
++  new-line-url
  |=  wal=(list tape)
  ^-  (list tape)
  %-  zing
  %+  turn  wal
  |=  =tape
  =/  new-line  (find "\0a" tape)
  =/  urli  (find "://" tape)
  ?.  &(=(~ new-line) =(~ urli))
    ?.  (gth +:new-line +:urli)
    =/  txt  (oust [+(+:new-line) (sub (lent tape) +:new-line)] tape)
    =/  url  (oust [0 +(+:new-line)] tape)
    [txt url ~]
    =/  url  (oust [+:new-line (sub (lent tape) +:new-line)] tape)
    =/  txt  (oust [0 +:new-line] tape)
    [url txt ~]
  [tape ~]
::
++  date-to-tape 
  |=  [old=@da now=@da]
  ^-  tape
  =/  tarp-now=tarp  (yell now)
  =/  tarp-old=tarp  (yell old)
  =/  d  (sub d:tarp-now d:tarp-old)  
  ?~  d
    =/  h  (sub h:tarp-now h:tarp-old)
    ?~  h
      =/  m  (sub m:tarp-now m:tarp-old)
      ?~  m
        ?~  (sub s:tarp-now s:tarp-old)
          "now"
        "{<(sub s:tarp-now s:tarp-old)>} {?:(=(1 (sub s:tarp-now s:tarp-old)) "second" "seconds")} ago"
      "{<m>} {?:(=(1 m) "minute" "minutes")} ago"
    "{<h>} {?:(=(1 h) "hour" "hours")} ago"
  =/  date-now  (yall d:tarp-now)
  =/  date-old  (yall d:tarp-old)
  ?:  &(!=(y:date-now y:date-old) (gte m:date-now m:date-old))
    =/  y  (sub y:date-now y:date-old)
    "{<y>} {?:(=(1 y) "year" "years")} ago" 
  ?:  &((gth m:date-now m:date-old) (gte d:date-now d:date-old))
    ?:  =(y:date-now y:date-old)
      =/  month  (sub m:date-now m:date-old)
      "{<month>} {?:(=(1 month) "month" "months")} ago" 
    =/  month  (sub (add m:date-now 12) m:date-old)
    "{<month>} {?:(=(1 month) "month" "months")} ago" 
  ?:  (gte d 7)
    "{<(div d 7)>} {?:(=(1 (div d 7)) "week" "weeks")} ago" 
  "{<d>} {?:(=(1 d) "day" "days")} ago" 
::
--

