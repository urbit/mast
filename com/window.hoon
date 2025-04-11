/-  mast, *window
:-  ^-  boom:mast
    :*  %window
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
  =/  win  !<  window  fil.sack
  =/  pol  ^-  (pole @ta)  path.crow
  ?+  pol  ~^~
    ::
      [%submit %go p=*]
    =/  paf  (stab (~(got by data.crow) 'path-input'))
    =/  com  (~(got by data.crow) 'component-input')
    =/  pos  (position p.pol)
    =/  dow  (get-window pos win)
    =.  dow  ?>  ?=(%$ -.dow)  dow(path paf, component com)
    =.  win  (put-window pos dow win)
    :_  ~
    :~  (write-file pax.scud [%window !>(win)])
    ==
    ::
      [%click %split p=@ta q=*]
    =/  pos  (position q.pol)
    =/  dow  (get-window pos win)
    =/  new
      ^-  window
      ?+  p.pol  !!
        %t  [%h [%$ %$ ~] dow]
        %b  [%h dow [%$ %$ ~]]
        %l  [%v [%$ %$ ~] dow]
        %r  [%v dow [%$ %$ ~]]
      ==
    =.  win  (put-window pos new win)
    :_  ~
    :~  (write-file pax.scud [%window !>(win)])
    ==
    ::
      [%click %close p=*]
    =/  pos  (position p.pol)
    =.  win  (del-window pos win)
    :_  ~
    :~  (write-file pax.scud [%window !>(win)])
    ==
    ::
  ==
::
++  sail
  :-  %hoot
  =/  pos  ^*  position
  =/  win  !<  window  fil.sack
  =/  won  win
  |-  ^-  manx:hoot
  ?-  -.win
    ::
      %$
    =/  pot=tape  ?.  .?  pos  ~  (spud pos)
    ;div.p2.b1.hf.wf.mono
      ;div.p2.mb1.b2
        ;div.fr.js
          ;div.wf
            ;button.p-1.b4.hover(event "/click/close{pot}"): close
          ==
          ;span.p-1: split:
          ;button.p-1.b4.hover(event "/click/split/l{pot}"): left
          ;button.p-1.b4.hover(event "/click/split/b{pot}"): down
          ;button.p-1.b4.hover(event "/click/split/t{pot}"): up
          ;button.p-1.b4.hover(event "/click/split/r{pot}"): right
        ==
        ;form.fr.ja.mt1(event "/submit/go{pot}")
          ;input.p-1.f0.b4.wf.hover
            =name  "path-input"
            =value  (spud path.win)
            =placeholder  "path"
            ;
          ==
          ;input.p-1.f0.b4.ml1.mr1.hover
            =name  "component-input"
            =value  (trip component.win)
            =placeholder  "component"
            ;
          ==
          ;button.p-1.b4.hover: go
        ==
      ==
      ;div.hf.scroll-y
        ;+  ?.  ?=(%$ component.win)
              %^  make-hoot:mast  component.win  path.win
              ~
            %^  make-hoot:mast  %explorer  (snip path.win)
            :~  :-  %selection   !>  `(unit term)`?~(path.win ~ [~ (rear path.win)])
                :-  %set-window  !>  `$-(open card:mast)`(prop-set-window [pax.scud pos won])
            ==
      ==
    ==
    ::
      %h
    ;div.fc.ac.hf
      ;+  $(win top.win, pos (snoc pos %t))
      ;+  $(win bot.win, pos (snoc pos %b))
    ==
    ::
      %v
    ;div.fr.jc.hf
      ;+  $(win lef.win, pos (snoc pos %l))
      ;+  $(win rig.win, pos (snoc pos %r))
    ==
    ::
  ==
::
--
|%
::
++  write-file
  |=  [to=path dat=cage]
  ^-  card:mast
  [%pass /write %arvo %c [%info %base %& [[to %ins dat] ~]]]
::
++  prop-set-window
  |=  [here=path pos=position win=window]
  |=  pen=open
  ^-  card:mast
  =/  dow  (get-window pos win)
  =.  win
    =;  new  (put-window pos new win)
    ^-  window
    ?~  p.pen  [%$ q.pen]
    ?-  u.p.pen
      %t  [%h [%$ q.pen] dow]
      %b  [%h dow [%$ q.pen]]
      %l  [%v [%$ q.pen] dow]
      %r  [%v dow [%$ q.pen]]
    ==
  %+  write-file  here  [%window !>(win)]
::
++  get-window
  |=  [pos=position win=window]
  ^-  window
  ?~  pos  win
  ?-  -.win
    %$  !!
    %h  ?+  i.pos  !!
          %t  $(win top.win, pos t.pos)
          %b  $(win bot.win, pos t.pos)
        ==
    %v  ?+  i.pos  !!
          %l  $(win lef.win, pos t.pos)
          %r  $(win rig.win, pos t.pos)
        ==
  ==
::
++  put-window
  |=  [pos=position new=window win=window]
  ^-  window
  ?~  pos  new
  ?-  -.win
    %$  !!
    %h  ?+  i.pos  !!
          %t  win(top $(win top.win, pos t.pos))
          %b  win(bot $(win bot.win, pos t.pos))
        ==
    %v  ?+  i.pos  !!
          %l  win(lef $(win lef.win, pos t.pos))
          %r  win(rig $(win rig.win, pos t.pos))
        ==
  ==
::
++  del-window
  |=  [pos=position win=window]
  ^-  window
  ?~  pos  *window
  ?-  -.win
    %$  !!
    %h  ?+  i.pos  !!
          %t  ?~  t.pos  bot.win  win(top $(win top.win, pos t.pos))
          %b  ?~  t.pos  top.win  win(bot $(win bot.win, pos t.pos))
        ==
    %v  ?+  i.pos  !!
          %l  ?~  t.pos  rig.win  win(lef $(win lef.win, pos t.pos))
          %r  ?~  t.pos  lef.win  win(rig $(win rig.win, pos t.pos))
        ==
  ==
::
--

