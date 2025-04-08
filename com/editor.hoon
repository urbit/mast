/-  mast
:-  ^-  boom:mast
    :*  %txt
        %z
        !>(~)
    ==
^-  mast:mast
|_  [=scud:mast =sack:mast]
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ?+  -.crow  ~^~
    ::
      [%submit %save ~]
    :: =/  txt  !<  wain  fil.sack
    =/  dat  (~(got by data.crow) 'editor-input')
    :_  ~
    :~  [%pass /write %arvo %c [%info %base %& [[pax.scud %ins %txt !>([dat ~])] ~]]]
    ==
    ::
      [%click %save ~]
    :: =/  txt  !<  wain  fil.sack
    =/  dat  (~(got by data.crow) '/target/value')
    :_  ~
    :~  [%pass /write %arvo %c [%info %base %& [[pax.scud %ins %txt !>([dat ~])] ~]]]
    ==
    ::
  ==
::
++  sail
  ^-  manx
  =/  txt  !<  wain  fil.sack
  ;div
    ;p: test
    ;form(event "/submit/save")
      :: ;input(name "editor-input", value txt);
      ;textarea(name "editor-input", value txt);
      ;button: save
    ==

    :: ;input(name "editor-input", value txt);
    :: ;button(event "/click/save", return "/target/value"): save

    :: ;p: {txt}
  ==
::
--

