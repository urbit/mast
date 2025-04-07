/-  mast
:-  ^-  boom:mast
    :*  %txt
        %z
        !>("")
    ==
^-  mast:mast
|_  [=scud:mast =sack:mast]
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ?+  -.crow  ~^~
    ::
      [%click %test ~]
    =/  loc  !<  tape  loc.sack
    =/  txt  !<  wain  fil.sack
    :-  ~
    !>  "{loc}!"
    ::
  ==
::
++  sail
  ^-  manx
  =/  hid  (~(get by pop.sack) %hide)
  =/  loc  !<  tape  loc.sack
  =/  txt  !<  wain  fil.sack
  ;div
    ;p: {<pax.scud>}
    ;*  ?:  &(?=(^ hid) !<(bean u.hid))  ~
        ;=  ;p: Txt:
            ;p: {<txt>}
            ;button(event "/click/test"): click me{loc}
        ==
  ==
::
--

