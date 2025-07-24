/-  mast, athens
^-  mast:mast
:-  :~  post+%athens-post
        view+%noun
        new+%noun
    ==
=<
|_  =hull:mast
::
+*  post  (~(got by res.hull) %post)
    viw  !<  view:athens  fil:(~(got by res.hull) %view)
    new-posts  !<  (list path)  fil:(~(got by res.hull) %new)
    hid   =(-.viw %hidden)
    new   =(-.viw %new)
    show  =(-.viw %display-none)
    sel   ;;  ?  
          ?:  |(=(-.viw %new) =(-.viw %old))  
            +.viw 
          ?:  =(-.viw %hidden)  `?`+.+.+.viw
          |
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  =/  paf  src:post
  ?>  ?=([%athens %posts *] paf)
  ?+  path.crow  ~
    ::
      [%click %toggle-hide ~]
    =/  id  (slav %da (rear src:post))
    ?:  hid
      :~  [%athens %athens-action !>([%unhide-post t.t.paf])]
      ==
    :~  [%athens %athens-action !>([%hide-post t.t.paf])]
    ==
    ::
      [%submit %hide ~]
    =/  id  (slav %da (rear src:post))
    ?<  hid
    :~  [%athens %athens-action !>([%hide-post t.t.paf])]
    ==
    ::
      [%click %unhide ~]
    =/  id  (slav %da (rear src:post))
    ?>  hid
      :~  [%athens %athens-action !>([%unhide-post t.t.paf])]
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
      [%submit %selected ~]
    ?<  sel
    :~  [%athens %athens-action !>([%set-user-position t.t.paf])]
    ==
    ::
  ==
::
++  sail
  ^-  manx
  =/  [paf=path dat=[[post=post:athens rep-num=@] rep=(list path)]]  =+(post [src !<([[post:athens @] (list path)] fil)])
  =/  idt  (trip (rear paf)) 
  =/  num-lines  (lent (to-wain:format content.post.dat))
  =/  sticky  ?:((gth num-lines 8) "md:sticky" "")
  =/  user=@p  (slav %p (~(got by par.hull) %fingerprint))
  =/  is-author  =(user author.post.dat)
  =/  reply=?
    ?>  ?=([%athens %posts *] paf)
    (gth (lent t.t.paf) 1) 
  =/  depth=@
    =-  (mul (dec -) 8)
    ?>  ?=([%athens %posts *] paf)
    ?:  (gth (lent t.t.paf) 2) 
      (dec (lent t.t.paf))  
    1
  =/  scroll
    ?:  ?&  !=(new-posts ~)
            hid
        ==
      ""
      ::"delayedScrollToTop('{(trip (rear (head new-posts)))}')"
    ""
  |^
    ?:  show  ;div.hidden;
    ?:  &(hid !=(-.+.viw 0))  nested-replies
    =/  has-new  ?^(`*`+.viw (gth -.+.+.viw 0) |)
    ;div
      =event  "{?:(hid "/click/unhide" "")}"
      ::=onclick  scroll
      =id  idt
      =class  "post-node-container flex flex-col md:gap-[16px] gap-[16px] ".
              "{?~(hid "cursor-pointer" "")} ".
              "{?:(sel "selected" "")}"
      ;div
        =id  "post-{idt}"
        =class  "post-container relative grid grid-cols-2 ".
                "grid-rows-[min-content] gap-y-[16px] md:gap-x-4 ".
                "md:pb-[0px] w-full md:grid-cols-3 md:flex-row ".
                "md:items-start md:w-full md:grid-cols-[min-content_auto_120px] box-border ".
                "{?:(hid "open" "")} ".
                "{?:(&(hid has-new) "has-new" "")}"
        ;+  author
        ;+  
          =/  depth=@
            =-  (mul (dec -) 8)
            ?>  ?=([%athens %posts *] paf) 
            ?:  (gth (lent t.t.paf) 2) 
              (dec (lent t.t.paf))
            1
          ;div
            =class  "message {?:(hid "hide md:w-[95%] w-[85%]" "full")} ".
                    "{?.(reply "" "reply")} col-span-2 md:col-start-2 ".
                    "md:col-span-1 row-start-2 md:row-start-1 flex flex-col ".
                    "gap-[8px] md:gap-[16px] md:flex-grow ml-[{((d-co:co 1) depth)}px] ".
                    "border-l-0 relative overflow-hidden" 
            ;+  edit-form
            ;athens-preview
              =value  (trip content.post.dat)
              =class  "w-full resize-none overflow-x-hidden overflow-y-hidden ".
                      "box-border text-sm ".
                      "{?:(new "text-fade" "")} {?:(hid "hide" "")}"
              ;
            ==
            ;+  ?:  hid
                  ;div.hidden;
                reply-form
          ==
        ;+  ?:  ?&  ?|  =((lent paf) 4)
                        !=(~ rep.dat)
                    ==
                !hid
                ==
          ;form(event "/submit/hide", class "track-visibility opacity-0 pointer-events-none md:col-start-2 md:col-span-1 row-start-2 md:row-start-1");
        ;div.hidden;
        ;form(event "/submit/selected", class "submit-selected submit-selected-{idt} opacity-0 pointer-events-none md:col-start-2 md:col-span-1 row-start-2 md:row-start-1");
        ;+  post-metadata
        ;+  option-buttons
      ==
      ;+  
        ?:  ?|  hid
                ?=(~ rep.dat)
            ==
          ;div.hidden;
        make-replies
    ==
  ++  nested-replies
    =/  new-rep  -.+.+.viw
    ;div(event "/click/unhide")
      =id  idt
      =onclick  scroll
      =class  "relative grid grid-cols-2 ".
              "grid-rows-[min-content] gap-y-[16px] md:gap-x-4 ".
              "md:pb-[0px] w-full md:grid-cols-3 md:flex-row ".
              "md:items-start md:w-full md:grid-cols-[min-content_auto_120px] grid-cols-[1fr_min-content] ".
              "form-post-wrapper cursor-pointer"
      ;div(class "author w-[15ch] max-w-[15ch] md:col-start-1 md:row-start-1 hidden md:block");
      ;div
        =class  "message w-full col-start-1 md:col-start-2 md:col-span-1 ".
                "row-start-1 md:row-start-1 flex ".
                "flex-row md:flex-grow ml-[0px] border-l-0 ".
                "ml-[{((d-co:co 1) depth)}px] pl-2 items-center"
          ;span.whitespace-pre: {<posts.-.+.viw>} 
          ;span:  posts
          ;div(class "ml-4 flex-grow h-px bg-[var(--grey-light)] opacity-50");
      ==
      ;div
        =class  "col-start-2 md:col-start-3 row-start-1 md:row-start-1 flex justify-end md:justify-start"
        ;div
          =class  "reply-num pr-4 text-[var(--grey-default)] inline ".
                  "whitespace-nowrap w-auto text-[var(--grey-default)] ".
                  "leading-none align-top justify-end"
          ;span
            =class  "text-white {?:((gth `@ud`new-rep 0) "new" "")}"
            {?:((gth `@ud`new-rep 0) "+{(scow %ud new-rep)} " " ")}
          ==
        ==
        ;div
          =class  "reply-date inline leading-none align-top ".
                  "whitespace-nowrap w-auto text-[var(--grey-default)] ".
                  "{?:((gth -.+.+.viw 0) "!text-white" "")} "
          =style  "font-weight: 400"
          {(date-to-tape (slav %da (rear paf)) now.hull)}
        ==
      ==
    ==
  ::
  ++  author
    ;div
      =event  "{?~(hid "" "/click/toggle-hide")}"
      =class  "author {?:(hid "hide" "")} {sticky} md:translate-y-[-1px] ".
              "top-20 cursor-pointer w-[15ch] max-w-[15ch] ".
              "ml-[{((d-co:co 1) depth)}px] overflow-hidden ".
              "whitespace-nowrap flex items-start col-start-1 ".
              "row-start-1 md:text-right {?.(reply "" "pl-2")} md:pl-0"
      ;span(class "inline-block leading-none align-top w-full")
        ;-
          %-  cite:title
          author.post.dat
      ==
    ==
  ++  edit-form
    ;div(id "edit-{idt}", class "edit-form form hidden md:hidden fixed bottom-[24px] inset-x-0 z-51 md:w-full")
      ;div
        =class  "form-post-wrapper md:grid md:grid-rows-[min-content] ".    
                "md:grid-cols-3 md:items-start md:grid-cols-[15ch_auto_120px] ".
                "mx-4 md:gap-x-4 mx-auto max-w-[1000px]"
        ;div 
          =class  "mx-4 border-b-0 md:col-start-2 ".
                  "form-wrapper-border rounded-md shadow-md bg-[var(--bg-color)] ".
                  "mx-4 focus-within:!border-white focus-within:!text-white"
          ;div
            =class  "flex justify-between items-center px-2 py-[10px] text-[var(--grey-light)] h-[28px]"
            ;p.form-reply-text
              ;  Edit
            ==
            ;button.cursor-pointer
              =onclick  "toggleView('edit-{idt}', true)"
              =style  "font-size: 16px;"
              ; x
            ==
          ==
          ;form
            =name      "edit-form"
            =event     "/submit/edit"
            =onsubmit  "toggleView('edit-{idt}', true)"
            =class  "post-reply-form form-reply w-full ".
                    "resize-none overflow-hidden box-border ".
                    "flex items-stretch justify-between gap-0 ".
                    "[&.is-focused]:!border-white [&.is-focused]:!text-white"
            ;athens-textarea-litdev(value (trip content.post.dat), class "grow", name "edit-input", textareaClass "track-focus");
            ;button 
              =class  "mt-auto p-2 text-[14px] h-[28px] flex items-center justify-center"
              ; →
            ==
          ==
        ==
      ==
    ==
  ::
  ++  reply-form
    ;div(id "reply-{idt}", class "reply-form form hidden md:hidden fixed bottom-[24px] inset-x-0 z-50 md:w-full")
      ;div
        =class  "form-post-wrapper md:grid md:grid-rows-[min-content] ".    
                "md:grid-cols-3 md:items-start md:grid-cols-[15ch_auto_120px] ".
                "mx-4 md:gap-x-4 mx-auto max-w-[1000px]"
        ;div
          =class  "mx-4 border-b-0 md:col-start-2 ".
                  "form-wrapper-border rounded-md shadow-md ". 
                  "bg-[var(--bg-color)] focus-within:!border-white ". 
                  "focus-within:!text-white"
          ;div 
            =class  "flex justify-between items-center px-2 py-[10px] text-[var(--grey-light)] h-[28px]"
            ;p.form-reply-text
              ;  Replying to {(cite:title author.post.dat)}
            ==
            ;button.cursor-pointer(onclick "toggleView('reply-{idt}', true)")
              =style  "font-size: 16px;"
              ; x
            ==
          ==
          ;form
            =class  "post-form form-reply rounded-md shadow-md ".
                    "overflow-hidden box-border flex items-stretch ".
                    "md:rounded-none md:shadow-none md:p-0 ".
                    "[&.is-focused]:!border-white [&.is-focused]:!text-white z-10" 
            =name      "reply-form"
            =event     "/submit/reply"
            =onsubmit  "toggleView('reply-{idt}', true)"
            ;athens-textarea-litdev.grow
              =name       "reply-input"
              ;
            ==
            ;button
              =type   "submit"
              =class  "mt-auto p-2 text-[14px] h-[28px] flex items-center justify-center"
              ; →
            ==
          ==
        ==
      ==
    ==
  ::
  ++  post-metadata
    =/  rep      rep-num.dat
    =/  new-rep  ?:  hid  -.+.+.viw  0
    ^-  manx
    ;div 
      =class  "md:col-start-3 md:row-start-1 flex flex-row ". 
              "justify-end md:justify-start {?:(hid "" "hidden")}"
      ;+  ?:  &(=(0 rep) =(new-rep 0))  ;div.hidden;
          ;div 
            =class  "reply-num {?:(hid "hide" "full")} pr-4 ".
                    "text-[var(--grey-default)] inline whitespace-nowrap ". 
                    "w-auto text-[var(--grey-default)] md:w-[7ch] w-auto ". 
                    "leading-none align-top justify-end"
            {?:((gth `@ud`rep 0) <rep> "")}
            ;span
            =class  "text-white {?:((gth `@ud`new-rep 0) "new" "")}"
              {?:(&((gth `@ud`rep 0) (gth `@ud`new-rep 0)) "+" "")}{?:((gth `@ud`new-rep 0) "{(scow %ud -.+.+.viw)}" "")}
            ==
          ==
        ;div
          =class  "reply-date {?:(hid "hide" "full")} inline ".
                  "whitespace-nowrap w-auto text-[var(--grey-default)] ".
                  "leading-none align-top {?:((gth new-rep 0) "!text-white" "")} ".
                  "{?:(&(=(0 rep) =(new-rep 0)) "md:pl-[7ch]" "")}"
          {(date-to-tape (slav %da (rear paf)) now.hull)}
        ==
      ==
  ::
  ++  option-buttons
  ?:  hid  
    ;div.hidden;
  ;div
    =class  "options {sticky} top-20 col-start-2 ".
            "row-start-1 md:col-start-3 md:row-start-1 ".
            "flex gap-1 justify-end md:invisible visible ".
            "color-[#646464] {?:(hid "hidden" "")}  translate-y-[-1px] ".
            "leading-none align-top md:justify-start"
      ;button(onclick "toggleView('reply-{idt}', true, true)"): reply
    ;*  ?:  is-author
      ;=
        ;button(onclick "toggleView('edit-{idt}', true, true)"): edit
        ;button(event "/click/delete"): delete
      ==
    ~
  ==
  ::
  ++  make-replies 
    =/  depth=@
      =-  (mul (dec -) 8)
      ?>  ?=([%athens %posts *] paf)
        (lent t.t.paf)  
    ;div.replies-container.relative
      ;div(class "border-left absolute w-px bg-[var(--grey-default)] top-0 bottom-[2px]", style "--depth: {((d-co:co 1) depth)}px;");
      ;*  ?>  ?=([%athens %posts *] paf)
          %+  turn  rep.dat
          |=  p=path
          %^  make:mast  mast/%athens-post
            :~
              :-  %fingerprint  (~(got by par.hull) %fingerprint)
            ==
          :~  [%post (welp paf p)] 
              [%view (welp /athens/view/[(scot %p src.hull)] (welp t.t.paf p))]
              [%new (welp /athens/new/[(scot %p src.hull)] (welp t.t.paf p))] 
          ==
    ==
  --
::
--
|%
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
    "{<(div d 7)>}w" 
  "{<d>}d" 
::
--