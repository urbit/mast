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
    :_  !>  loc(reply !reply.loc)
    :~  (make-action-card scud %put-post t.t.pax.scud dat)
    ==
    ::
  ==
::
++  sail
  ^-  manx
  =/  loc  !<  [hidden=? reply=?]  loc.sack
  =/  dat  !<  post:athens  fil.sack
  ;div.post-node-container
    ;div.post-container
      ;div.post.pointer
        ;div.author(event "/click/toggle-hide"): {(cite:title author.dat)}
      ==
      ;+  ?:  hidden.loc  ;div;
          =/  depth=@  =-  (dec -)  ?>  ?=([%athens %posts *] pax.scud)  (lent t.t.pax.scud)
          ;div
            =class  "message full {?:(=(0 depth) "" "reply")}"
            =style  "margin-left: {((d-co:co 1) depth)}em"
            ;div: {(trip content.dat)}
            ;+  ?.  reply.loc
                  ;div;
                ;form(event "/submit/reply")
                  ;input.post-input(name "reply-input", placeholder "Write something...");
                ==
          ==
        ;div.options
          ;button(event "/click/toggle-reply"): reply
          ;button: edit
          ;button: delete
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
++  make-action-card
  |=  [sud=scud:mast act=action:athens]
  ^-  card:agent:gall
  [%pass /athens-post %agent [our.sud %athens] %poke %athens-action !>(act)]
::
--

