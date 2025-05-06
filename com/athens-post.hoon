/-  mast, athens
:-  ^-  boom:mast
    :*  %athens-post
        %z
        !>(|^|)
    ==
=<
^-  mast:mast
|_  [=scud:mast =sack:mast]
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  =/  loc  !<  [hidden=? reply=?]  loc.sack
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
      [%submit %reply ~]
    ?>  ?=([%athens %posts *] pax.scud)
    =/  dat  (~(got by data.crow) 'reply-input')
    ?:  =('' dat)  ~^~
    :_  !>(loc(reply !reply.loc))
    :~  [%athens %athens-action !>([%put-post t.t.pax.scud dat])]
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
  =/  loc  !<  [hidden=? reply=?]  loc.sack
  =/  dat  !<  post:athens  fil.sack
  =/  is-comet=?  ?=(%pawn (clan:title yon.scud))
  ;div.post-node-container
    ;div.post-container
      ;div.post.pointer
        ;div(event "/click/toggle-hide")
          =class  "author {?:(hidden.loc "hide" "")}"
          ;+  ;/  (cite:title author.dat)
        ==
      ==
      ;+  =/  depth=@  =-  (dec -)  ?>  ?=([%athens %posts *] pax.scud)  (lent t.t.pax.scud)
          ;div
            =class  "message {?:(hidden.loc "hide" "full")} {?:(=(0 depth) "" "reply")}"
            =style  "margin-left: {((d-co:co 1) depth)}em"
            ;+  ;/  (trip content.dat)
            ;+  ?:  |(!reply.loc hidden.loc)
                  ;div;
                ;form.post-form(event "/submit/reply")
                  ;textarea(name "reply-input", placeholder "Write something...");
                  ;button: 🠊
                ==
          ==
      ;+  ?:  ?|  hidden.loc
                  is-comet
              ==
            ;div;
          ;div.options
            ;button(event "/click/toggle-reply"): reply
            ;button: edit
            ;button(event "/click/delete"): delete
          ==
    ==
    ;+  ?:  ?|  hidden.loc
                ?=(~ kid.scud)
            ==
          ;div;
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
--

