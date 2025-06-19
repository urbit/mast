/-  mast, athens
^-  mast:mast
:-  :~  post+%athens-post
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
    =/  paf  src:post
    ?>  ?=([%athens %posts *] paf)
    =/  dat  (~(got by data.crow) 'reply-input')
    ?:  =('' dat)  ~
    :~  [%athens %athens-action !>([%put-post t.t.paf dat])]
    ==
    ::
  ==
  :: =/  loc  !<  [hidden=? reply=?]  loc.sack
  :: =/  pol  ^-  (pole @ta)  path.crow
  :: ?+  pol  ~^~
  ::   ::
  ::     [%click %toggle-hide ~]
  ::   :-  ~
  ::   !>  loc(hidden !hidden.loc)
  ::   ::
  ::     [%click %toggle-reply ~]
  ::   :-  ~
  ::   !>  loc(reply !reply.loc)
  ::   ::
  ::     [%submit %reply ~]
  ::   ?>  ?=([%athens %posts *] pax.scud)
  ::   =/  dat  (~(got by data.crow) 'reply-input')
  ::   ?:  =('' dat)  ~^~
  ::   :_  !>(loc(reply !reply.loc))
  ::   :~  [%athens %athens-action !>([%put-post t.t.pax.scud dat])]
  ::   ==
  ::   ::
  ::     [%click %delete ~]
  ::   ?>  ?=([%athens %posts *] pax.scud)
  ::   :_  ~
  ::   :~  [%athens %athens-action !>([%del-post t.t.pax.scud])]
  ::   ==
  ::   ::
  :: ==
::
++  sail
  ^-  manx
  =/  reply  |
  =/  hid  is-hidden
  =/  [paf=path dat=post-view:athens]  =+(post [src !<(post-view:athens fil)])
  =/  is-comet=?  |  :: ?=(%pawn (clan:title (need src.hull)))
  =/  idt  (trip (rear paf))
  ;div.post-node-container
    ;div.post-container
      ;div.post.pointer
        ;div(event "/click/toggle-hide")
          =class  "author {?:(hid "hide" "")}"
          ;+  ;/  (cite:title author.dat)
        ==
      ==
      ;+  =/  depth=@  =-  (dec -)  ?>  ?=([%athens %posts *] paf)  (lent t.t.paf)
          ;div
            =class  "message {?:(hid "hide" "full")} {?:(=(0 depth) "" "reply")}"
            =style  "margin-left: {((d-co:co 1) depth)}em"
            ;+  ;/  (trip content.dat)
            ;form.post-form
              =event  "/submit/reply"
              =client-display  "reply {idt}"
              ;textarea(name "reply-input", placeholder "Write something...");
              ;button: 🠊
            ==
          ==
      ;+  ?:  ?|  hid
                  is-comet
              ==
            ;div;
          ;div.options
            ;button(client-display "reply !{idt}", client-event "click reply {(trip (rear paf))}"): reply
            ;button(client-display "reply {idt}", client-event "click reply ~"): reply
            ;button: edit
            ;button(event "/click/delete"): delete
          ==
    ==
    ;+  ?:  ?|  hid
                ?=(~ replies.dat)
            ==
          ;div;
        ;div.replies-container
          ;*  %+  turn  replies.dat
              |=  p=path
              %^  make:mast  mast/%athens-post  ~
              :~  [%post (weld paf p)]
                  [%hidden /athens/hidden/[(scot %p src.hull)]/[(rear p)]]
              ==
        ==
  ==
::
--
|%
::
++  mysterious-arm  ~
::
--

