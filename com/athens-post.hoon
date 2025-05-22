/-  mast, athens
:-  ^-  boom:mast
    :*  %athens-post
        %z
        !>(|^|^|)
    ==
=<
^-  mast:mast
|_  [=scud:mast =sack:mast]
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  =/  loc  !<  [hidden=? reply=? edit=?]  loc.sack
  =/  pol  ^-  (pole @ta)  path.crow
  ?+  pol  ~^~
    ::
      [%click %toggle-hide ~]
    :-  ~
    !>  loc(hidden !hidden.loc)
    ::
      [%click %toggle-reply ~]
    :-  ~
    !>  loc(reply !reply.loc)
    ::
      [%click %toggle-edit ~]
    :-  ~
    !>  loc(edit !edit.loc)
    ::
      [%submit %reply ~]
    ?>  ?=([%athens %posts *] pax.scud)
    =/  dat  (~(got by data.crow) 'reply-input')
    ?:  =('' dat)  ~^~
    :_  !>(loc(reply !reply.loc))
    :~  [%athens %athens-action !>([%put-post t.t.pax.scud dat])]
    ==
      [%submit %edit ~]
    ?>  ?=([%athens %posts *] pax.scud)
    =/  dat  (~(got by data.crow) 'edit-input')
    ?:  =('' dat)  ~^~
    :_  !>  loc(edit |)
    :~  [%athens %athens-action !>([%patch-post t.t.pax.scud dat])]
    ==
    ::
      [%click %delete ~]
    ?>  ?=([%athens %posts *] pax.scud)
    :_  ~
    :~  [%athens %athens-action !>([%del-post t.t.pax.scud])]
    ==
    ::
  ==
::
++  sail
  ^-  manx
  =/  loc  !<  [hidden=? reply=? edit=?]  loc.sack
  =/  dat  !<  post:athens  fil.sack
  ::=/  content-wall  (parse-content (trip content.dat))
  =/  is-comet=?  ?=(%pawn (clan:title yon.scud))
  ;div
    =class  "post-node-container flex flex-col md:gap-[16px] gap-[4px]"
    ;div
      =class  "post-container grid grid-cols-2 grid-rows-[min-content] gap-y-[12px] md:pb-[0px] w-full md:flex md:flex-row md:items-start md:justify-between md:w-full"
      ;*  =/  depth=@  =-  (dec -)  ?>  ?=([%athens %posts *] pax.scud)  (lent t.t.pax.scud)
        ;=
          ;div
            =class  "pointer col-start-1 row-start-1 md:flex md:gap-4"
            ;div(event "/click/toggle-hide")
              =class  "author {?:(hidden.loc "hide" "")} w-[15ch] pr-4 ml-[{((d-co:co 1) depth)}em]"
              ;-  (cite:title author.dat)
            ==
          ==
          ;div 
            =class  "message {?:(hidden.loc "hide" "full")} {?:(=(0 depth) "" "reply")} col-span-2 row-start-2 flex flex-col gap-[8px] md:gap-[16px] md:flex-grow ml-[{((d-co:co 1) depth)}em] border-l-0"
            ;+  ?:  &(edit.loc !hidden.loc)
                ;form(event "/submit/edit")
                =class  "post-reply-form w-full min-h-[26px] resize-none overflow-hidden box-border"
                  ;athens-textarea-litdev(value (trip content.dat), class "w-full min-h-[26px] resize-none overflow-auto md:overflow-hidden box-border p-[11px] text-sm", textareaClass "md:overflow-hidden box-border text-sm", name "edit-input");
                  ;button.mt-auto.p-2(event "/click/toggle-edit")
                    ;span: →
                  ==
                == 
              ;athens-textarea-litdev(class "w-full resize-none overflow-hidden box-border text-sm {?:(hidden.loc "hide" "")}", name "preview-only", value (trip content.dat), preview-only "true"); 
              ;+  ?:  |(!reply.loc hidden.loc)
                  ;div.hidden;
                ;form.post-reply-form(event "/submit/reply")
                  ;athens-textarea-litdev(class "w-full min-h-[26px] resize-none overflow-auto md:overflow-hidden box-border text-sm p-[11px]", textareaClass "md:overflow-hidden box-border text-sm", name "reply-input");
                  ;button.mt-auto.p-2(type "submit")
                    ;span: →
                  ==
                ==
          ==
        ==
      ;div.flex.flex-row
        ;+  ?:  =(0 (lent kid.scud))
            ;div.hidden;
          ;div
            =class  "reply-num {?:(hidden.loc "hide" "full")} pr-2 text-[{txt-color}]"
            ;p.inline.whitespace-nowrap.w-auto: {<(lent kid.scud)>} {?:(=(1 (lent kid.scud)) " reply" " replies")}
          ==
        ;div
          =class  "reply-date {?:(hidden.loc "hide" "full")} inline whitespace-nowrap w-auto text-[{txt-color}]"
          {(date-to-tape (slav %da (rear pax.scud)) now.scud)}
        ==
      ==
      ;+  ?:  is-comet
            ;div.hidden;
          ;div
            =class  "options col-start-2 row-start-1 flex gap-2 justify-end md:invisible visible color-[#646464]"
            ;*  ?:  =(author.dat yon.scud)
              ;=
                ;button(event "/click/toggle-edit"): edit
                ;button(event "/click/delete"): delete
              ==
            ~
            ;button(event "/click/toggle-reply"): reply
          ==
    ==
    ;+  ?:  ?|  hidden.loc
                ?=(~ kid.scud)
            ==
          ;div.hidden;
        ;div.replies-container
          ;*  %+  turn  kid.scud
              |=  p=path
              (make:mast %athens-post (weld pax.scud p) ~)
        ==
  ==
::
--
|%
::
++  mysterious-arm  ~
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