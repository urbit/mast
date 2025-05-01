/-  mast, athens
:-  ^-  boom:mast
    :*  %athens
        %z
        !>(~)
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
      [%test p=*]
    ~^~
    ::
  ==
::
++  sail
  ^-  manx
  =/  state  !<  state:athens  fil.sack
  ;div
    ;h1: Athens
    ;*  %+  turn  (tap:posts-on posts.state)
        |=  [k=post-id:athens v=post:athens]
        ;div
          ;p: {(scow %p author.v)}
          ;p: {(trip content.v)}
        ==
  ==
::
--
|%
::
++  posts-on  ((on post-id:athens post:athens) lte)
::
--

