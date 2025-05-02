/-  mast, athens
:-  ^-  boom:mast
    :*  %athens-post
        %z
        !>(|)
    ==
=<
^-  mast:mast
|_  [=scud:mast =sack:mast]
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  =/  pol  ^-  (pole @ta)  path.crow
  ?+  pol  ~^~
    ::
      [%click %toggle-hide ~]
    =/  hid  !<  ?  loc.sack
    :-  ~  !>(!hid)
    ::
      [%submit %reply ~]
    ?>  ?=([%athens %posts *] pax.scud)
    =/  dat  (~(got by data.crow) 'reply-input')
    :_  ~
    :~  (make-action-card scud %put-post t.t.pax.scud dat)
    ==
    ::
  ==
::
++  sail
  ^-  manx
  =/  hid  !<  ?  loc.sack
  =/  dat  !<  post:athens  fil.sack
  ;div
    ;p(event "/click/toggle-hide"): {(scow %p author.dat)}
    ;+  ?:  hid
          ;div;
        ;div
          ;p: {(trip content.dat)}
          ;span: replies
          ;*  %+  turn  kid.scud
              |=  p=path
              (make:mast %athens-post (weld pax.scud p) ~)
          ;form(event "/submit/reply")
            ;input(name "reply-input");
            ;button: Reply
          ==
        ==
    ;hr;
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

