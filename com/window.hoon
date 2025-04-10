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
  =/  pos  ^*  position
  =/  win  !<  window  fil.sack
  |-  ^-  manx
  ?-  -.win
    ::
      %$
    =/  pot=tape  ?.  .?  pos  ~  (spud pos)
    ;div.grow.mono.fc.basis-half.shrink-0.p2
      ;div.fc.bd1.grow
        ;div.p2.b1.fc.g2
          ;div.fr.js
            ;div.wf
              ;button.p-1.b4.hover(event "/click/close{pot}"): {close-x}
            ==
            ;span.p-1: split:
            ;button.p-1.b4.hover(event "/click/split/l{pot}"): {arrow-l}
            ;button.p-1.b4.hover(event "/click/split/b{pot}"): {arrow-d}
            ;button.p-1.b4.hover(event "/click/split/t{pot}"): {arrow-u}
            ;button.p-1.b4.hover(event "/click/split/r{pot}"): {arrow-r}
          ==
          ;form.fr.g2(event "/submit/go{pot}")
            ;input.p-1.f0.b2.wf.hover.grow
              =name  "path-input"
              =value  (spud path.win)
              =placeholder  "path"
              =autocomplete  "off"
              =spellcheck  "false"
              ;
            ==
            ;input.p-1.f0.b2.hover
              =style  "width: 85px;"
              =name  "component-input"
              =value  (trip component.win)
              =placeholder  "component"
              =autocomplete  "off"
              =spellcheck  "false"
              ;
            ==
            ;button.p-1.b4.hover: go
          ==
        ==
        ;div.grow.scroll-y.b0.fc
          ;+  ?:  ?=(%$ component.win)
                ;div.p2: ~
              (make:mast component.win path.win ~)
        ==
      ==
    ==
    ::
      %h
    ;div.fc.grow.basis-half.shrink-0
      ;+  $(win top.win, pos (snoc pos %t))
      ;+  $(win bot.win, pos (snoc pos %b))
    ==
    ::
      %v
    ;div.fr.grow.basis-half.shrink-0
      ;+  $(win lef.win, pos (snoc pos %l))
      ;+  $(win rig.win, pos (snoc pos %r))
    ==
    ::
  ==
::
--
|%
::
::  unicode symbols
::
++  close-x  (trip 0x95.9ce2)
++  arrow-l  (trip 0x90.86e2)
++  arrow-r  (trip 0x92.86e2)
++  arrow-u  (trip 0x91.86e2)
++  arrow-d  (trip 0x93.86e2)
::
++  write-file
  |=  [to=path dat=cage]
  ^-  card:mast
  [%pass /write %arvo %c [%info %base %& [[to %ins dat] ~]]]
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