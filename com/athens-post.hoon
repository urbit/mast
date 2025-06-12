/-  mast, athens
^-  mast:mast
:-  :~  %auth
        post+%athens-post
        new+%noun
    ==
=<
|_  =hull:mast
::
+*  post  (~(got by res.hull) %post)
    hid   !=(~ (~(get by par.hull) %hidden))
    new   !=(~ (~(get by par.hull) %new))
    new-posts  !<  (list path)  fil:(~(got by res.hull) %new)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  =/  paf  src:post
  ?>  ?=([%athens %posts @ta *] paf)
  ?+  path.crow  ~
    ::
      [%click %toggle-hide ~]
    =/  id  (slav %da (rear src:post))
    ?:  hid
      :~  [%athens %athens-action !>([%unhide-post t.t.t.paf])]
      ==
    :~  [%athens %athens-action !>([%hide-post t.t.t.paf])]
    ==
    ::
      [%submit %hide ~]
    =/  id  (slav %da (rear src:post))
    ?<  hid
    :~  [%athens %athens-action !>([%hide-post t.t.t.paf])]
    ==
    ::
      [%click %unhide ~]
    =/  id  (slav %da (rear src:post))
    ?>  hid
      :~  [%athens %athens-action !>([%unhide-post t.t.t.paf])]
      ==
    ::
      [%submit %reply ~]
    =/  dat  (~(got by data.crow) 'reply-input')
    ?:  =('' dat)  ~
    :~  [%athens %athens-action !>([%put-post t.t.t.paf dat])]
    ==
    ::
      [%submit %edit ~]
    =/  dat  (~(got by data.crow) 'edit-input')
    ?:  =('' dat)  ~
    :~  [%athens %athens-action !>([%patch-post t.t.t.paf dat])]
    ==
    ::
      [%click %delete ~]
    :~  [%athens %athens-action !>([%del-post t.t.t.paf])]
    ==
    ::
  ==
::
++  sail
  ^-  manx
  =/  src  (need src.hull)
  =/  [paf=path dat=post-view:athens]  =+(post [src !<(post-view:athens fil)])
  =/  idt  (trip (rear paf)) 
  =/  num-lines  (lent (to-wain:format content.dat))
  =/  sticky  ?:((gth num-lines 8) "md:sticky" "")
  =/  is-comet=?  ?=(%pawn (clan:title src))
  =/  reply=?
    ?>  ?=([%athens %posts @ta *] paf)
    (gth (lent t.t.t.paf) 1) 
  =/  depth=@
    =-  (mul (dec -) 8)
    ?>  ?=([%athens %posts @ta *] paf)
    ?:  (gth (lent t.t.t.paf) 2) 
      (dec (lent t.t.t.paf))  
    1
  =/  scroll  
    ?:  ?&  !=(new-posts ~)
        hid
        ==
      "delayedScrollToCenter('{(trip (rear (rear new-posts)))}')"
    ""
  ;div
    =event  "{?~(hid "/click/unhide" "")}"
    =onclick  scroll
    =id  idt
    =class  "post-node-container flex flex-col md:gap-[16px] gap-[16px] {?~(hid "cursor-pointer" "")}"
    :: ;+  ?.  reply  ;div;
      :: ;div(class "border-left absolute w-px bg-[#737373] z-0 top-0 bottom-[5px]", style "--depth: {((d-co:co 1) depth)}px;");
    ;div
      =class  "post-container relative grid grid-cols-2 ".
              "grid-rows-[min-content] gap-y-[16px] md:gap-x-4 ".
              "md:pb-[0px] w-full md:grid-cols-3 md:flex-row ".
              "md:items-start md:w-full md:grid-cols-[min-content_auto_120px] z-10" 
      ;div(event "/click/toggle-hide")
        =class  "author {?:(hid "hide" "")} {sticky} ".
                "top-20 cursor-pointer w-[15ch] max-w-[15ch] ".
                "ml-[{((d-co:co 1) depth)}px] overflow-hidden ".
                "whitespace-nowrap flex items-start col-start-1 ".
                "row-start-1 md:text-right {?.(reply "" "pl-2")} md:pl-0"
        =client-event  "click edit ~" 
        ;span(class "inline-block leading-none align-top w-full"): {(cite:title author.dat)}
      ==
      ;+  
        =/  depth=@
          =-  (mul (dec -) 8)
          ?>  ?=([%athens %posts @ta *] paf)
          ?:  (gth (lent t.t.t.paf) 2) 
            (dec (lent t.t.t.paf))  
          1
        ;div
          =class  "message {?:(hid "hide md:w-[95%] w-[85%]" "full")} ".
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
              ;athens-textarea-litdev(value (trip content.dat), class "grow", name "edit-input");
              ;button 
                =event  "/click/toggle-edit"
                =class  "mt-auto p-2 text-[14px]"
                ;span: →
              == 
            ==
          ;athens-preview(value (trip content.dat)) 
            =client-display  "edit !{idt}"
            =class  "w-full resize-none overflow-hidden box-border text-sm {?:(new "text-fade" "")}{?:(hid "hide" "")}"
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
      ;+  ?:  ?&  ?|  =((lent paf) 4)
                      ?:  =(~ replies.dat)  |
                      %+  levy  replies.dat
                      |=  [p=path =view:athens]
                      =(-.view %hidden)
                  ==
              !hid
              ==
        ;form(event "/submit/hide", class "track-visibility opacity-0 pointer-events-none md:col-start-2 md:col-span-1 row-start-2 md:row-start-1");
      ;div.hidden;
      ;div
        =class  "md:col-start-3 md:row-start-1 flex flex-row justify-end md:justify-start {?:(hid "" "hidden")}"
        ;+  ?:  =(0 (lent replies.dat))
            ;div.hidden;
          ?:  hid
            =/  num  (slav %ud (~(got by par.hull) %hidden))
            ;div 
              =class  "reply-num {?:(hid "hide" "full")} pr-4 text-[{txt-color}] inline whitespace-nowrap w-auto text-[{txt-color}] inline-block leading-none align-top"
              {<(lent replies.dat)>}
              ;span.text-white: {?:((gth num 0) "+{<num>}" "")}
            ==
          ;div 
            =class  "reply-num {?:(hid "hide" "full")} pr-4 text-[{txt-color}] inline whitespace-nowrap w-auto text-[{txt-color}] inline-block leading-none align-top"
            {<(lent replies.dat)>}
          ==
        ;+
          ?:  hid
            =/  num  (slav %ud (~(got by par.hull) %hidden))
            ^-  manx
            ;div
              =class  "reply-date {?:(hid "hide" "full")} inline ".
                      "whitespace-nowrap w-auto text-[{txt-color}] inline-block ".
                      "leading-none align-top {?:((gth num 0) "!text-white" "")}"
              {(date-to-tape (slav %da (rear paf)) now.hull)}
            ==
          ;div
            =class  "reply-date {?:(hid "hide" "full")} inline ".
                    "whitespace-nowrap w-auto text-[{txt-color}] inline-block ".
                    "leading-none align-top"
            {(date-to-tape (slav %da (rear paf)) now.hull)}
          ==
      ==
      ;+  ?:  is-comet
            ;div.hidden;
          ;div
            =class  "options {sticky} top-20 col-start-2 ".
                    "row-start-1 md:col-start-3 md:row-start-1 ".
                    "flex gap-2 justify-end md:invisible  visible ".
                    "color-[#646464] {?:(hid "hidden" "")}  translate-y-[-1px] ".
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
          ?>  ?=([%athens %posts @ta *] paf)
            (lent t.t.t.paf)  
        ;div.replies-container.z-10.relative
          ;div(class "border-left absolute w-px bg-[#737373] z-0 top-0 bottom-[5px]", style "--depth: {((d-co:co 1) depth)}px;");
          ;*  ?>  ?=([%athens %posts *] paf)
              %+  turn  replies.dat
              |=  [p=path =view:athens]
              %^  make:mast  mast/%athens-post  
              :~  [-.view `@t`(scot %ud +.view)]
              ==
              :~  [%post (welp paf p)] 
                  [%new (welp /athens/new (welp t.t.paf p))] 
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
        "{<(sub s:tarp-now s:tarp-old)>}s"
      "{<m>}m"
    "{<h>}h"
  =/  date-now  (yall d:tarp-now)
  =/  date-old  (yall d:tarp-old)
  ?:  &(!=(y:date-now y:date-old) (gte m:date-now m:date-old))
    =/  y  (sub y:date-now y:date-old)
    "{<y>}y" 
  ?:  &((gth m:date-now m:date-old) (gte d:date-now d:date-old))
    ?:  =(y:date-now y:date-old)
      =/  month  (sub m:date-now m:date-old)
      "{<month>}M" 
    =/  month  (sub (add m:date-now 12) m:date-old)
    "{<month>}M" 
  ?:  (gte d 7)
    "{<(div d 7)>}d" 
  "{<d>}d" 
::
--

