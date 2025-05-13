/-  mast, athens
:-  ^-  boom:mast
    :*  %athens-post
        %z
        !>(&^|^|)
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
    :_  !>  loc
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
  =/  content-wall  (parse-content (trip content.dat))
  =/  is-comet=?  ?=(%pawn (clan:title yon.scud))
  ;div.post-node-container
    ;div.post-container.flex.items-center.justify-between
      ;div.flex.flex-row.w-full
        ;div.post.pointer
          ;div(event "/click/toggle-hide")
            =class  "author {?:(hidden.loc "hide" "")}"
            ;+  ;/  (cite:title author.dat)
          ==
        ==
        ;+  =/  depth=@  =-  (dec -)  ?>  ?=([%athens %posts *] pax.scud)  (lent t.t.pax.scud)
          ;div
            =class  "message {?:(hidden.loc "hide" "full")} {?:(=(0 depth) "" "reply")} flex flex-col gap-4"
            =style  "margin-left: {((d-co:co 1) depth)}em"
            ;+  ?:  edit.loc
                ;form.post-reply-form(event "/submit/edit")
                  ;athens-textarea(value (trip content.dat), class "w-full min-h-[26px] resize-none overflow-hidden font-inherit box-border p-1 text-sm", name "edit-input");
                  ;button(event "/click/toggle-edit"): edit 
                ==
              ;div
              ;*  %+  turn  content-wall
                  |=  =tape
                  ^-  manx
                  =/  new-line  (find "\0a" tape)
                  =/  urli  (find "://" tape)
                  ?.  =(~ urli)
                    ;a.underline/"{tape}": {(weld tape " ")}
                  ;/  (weld tape " ")
              ==
              ;+  ?:  |(!reply.loc hidden.loc)
                    ;div.hidden;
                  ;form.post-reply-form(event "/submit/reply")
                    ;athens-textarea(class "w-full min-h-[26px] resize-none overflow-hidden font-inherit box-border p-1 text-sm", name "reply-input");
                    ;button(event "/click/toggle-reply"): Cancel
                    ;button.reply-button(type "submit"): Reply
                  ==
          ==
      ==
      ;div.flex.flex-row
        ;+  ?:  =(0 (lent kid.scud))
            ;div.hidden;
          ;div
            =class  "reply-num {?:(hidden.loc "hide" "full")} pr-2"
            ;p.inline.whitespace-nowrap.w-auto: {<(lent kid.scud)>} {?:(=(1 (lent kid.scud)) " reply" " replies")}
          ==
        ;div
          =class  "reply-date {?:(hidden.loc "hide" "full")} inline whitespace-nowrap w-auto"
          {(date-to-tape (slav %da (rear pax.scud)) now.scud)}
        ==
      ==
      ;+  ?:  ?|  hidden.loc
                  is-comet
              ==
            ;div.hidden;
          ;div.options.flex
            ;button(event "/click/toggle-reply"): reply
            ;button(event "/click/toggle-edit"): edit
            ;button(event "/click/delete"): delete
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
++  parse-content
  |=  tap=tape
  %-  new-line-url
  ~&  tap
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