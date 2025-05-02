/-  mast, athens
:-  ^-  boom:mast
    :*  %$
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
      [%submit %post ~]
    :_  ~
    =/  dat  (~(got by data.crow) 'post-input')
    :~  (make-action-card scud [%put-post ~ dat])
    ==
    ::
  ==
::
++  sail
  ^-  manx
  ;div
    ;h1: Athens
    ;*  %+  turn  kid.scud
        |=  p=path
        (make:mast %athens-post (weld pax.scud p) ~)
    ;form(event "/submit/post")
      ;input(name "post-input");
      ;button: Post
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

