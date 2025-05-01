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
        ;p: {(trip content.dat)}
    ;hr;
  ==
::
--
|%
::
++  posts-on  ((on post-id:athens post:athens) lte)
::
--

