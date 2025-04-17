/-  mast, window
:-  ^-  boom:mast
    :*  %$
        %z
        !>(~)
    ==
=<
^-  mast:mast
|_  [=scud:mast =sack:mast]
::
  :: props:
+*  prop-selection   !<  (unit term)                (~(got by pop.sack) %selection)
    prop-set-window  !<  $-(open:window card:mast)  (~(got by pop.sack) %set-window)
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  =/  pol  ^-  (pole @ta)  path.crow
  ?+  pol  ~^~
    ::
      [%click %set-window p=*]
    =/  paf  (path p.pol)
    =/  pan  `pane:window`[%$ (weld pax.scud paf)]
    :_  ~
    :~  (prop-set-window ~ pan)
    ==
    ::
      [%click %set-window-with p=@ta q=*]
    =/  com  (~(got by data.crow) '/com-select/value')
    =/  wer  ?~(p.pol ~ [~ (place:window p.pol)])
    =/  paf  (path q.pol)
    =/  pan  `pane:window`[com (weld pax.scud paf)]
    :_  ~
    :~  (prop-set-window wer pan)
    ==
    ::
      [%click %set-window-back ~]
    ?~  pax.scud  ~^~
    =/  pan  `pane:window`[%$ pax.scud]
    :_  ~
    :~  (prop-set-window ~ pan)
    ==
    ::
  ==
::
++  sail
  ^-  manx
  =/  sel  prop-selection
  =/  dat  (get-column-data sel scud)
  ;div.fr.js
    ;div.fc.as.wf.p2
      ;button.b4.mb1.p-1.hover
        =event  "/click/set-window-back"
        ;+  ;/  "back"
      ==
      ;*  %+  turn  p.dat
          |=  i=column-item
          =/  seg-t  (trip seg.i)
          ?:  ?&  ?=(^ sel)
                  =(u.sel seg.i)
              ==
            ?:  fil.i
              ;div.wf.b4.f-3.bd2.bc-3
                ;+  ;/  seg-t
              ==
            ;div.wf.b4.f-4.bd2.bc-4
              ;+  ;/  seg-t
            ==
          ?:  fil.i
            ;button.wf.b4.f-3.hover.tl
              =event  "/click/set-window/{seg-t}"
              ;+  ;/  seg-t
            ==
          ;button.wf.b4.hover.tl
            =event  "/click/set-window/{seg-t}"
            ;+  ;/  seg-t
          ==
    ==
    ;+  ?:  ?&  ?=(^ sel)
                ?=(^ p.dat)
                fil.i.p.dat
            ==
          =/  seg-t  (trip u.sel)
          ;div.fr.ja.wf.p2.b4
            ;div.b4
              ;p: open with:
              ;select.hover
                =id  "com-select"
                ;*  %+  turn  com.scud
                    |=  i=cord
                    ^-  manx
                    =/  val  (trip i)
                    ;option(value val): {val}
              ==
            ==
            ;div.fr.js
              ;button.p-1.b4.hover
                =event  "/click/set-window-with//{seg-t}"
                =return  "/com-select/value"
                ;+  ;/  "here"
              ==
              ;button.p-1.b4.hover
                =event  "/click/set-window-with/l/{seg-t}"
                =return  "/com-select/value"
                ;+  ;/  "left"
              ==
              ;button.p-1.b4.hover
                =event  "/click/set-window-with/r/{seg-t}"
                =return  "/com-select/value"
                ;+  ;/  "right"
              ==
              ;button.p-1.b4.hover
                =event  "/click/set-window-with/t/{seg-t}"
                =return  "/com-select/value"
                ;+  ;/  "up"
              ==
              ;button.p-1.b4.hover
                =event  "/click/set-window-with/b/{seg-t}"
                =return  "/com-select/value"
                ;+  ;/  "down"
              ==
            ==
          ==
        ;div.fc.as.wf.p2
          ;*  %+  turn  q.dat
              |=  i=column-item
              ^-  manx
              ?~  sel  ;div;
              =/  seg-t  (trip seg.i)
              ?:  fil.i
                ;button.wf.f-3.b2.hover.tl
                  =event  "/click/set-window/{(trip u.sel)}/{seg-t}"
                  ;+  ;/  seg-t
                ==
              ;button.wf.f2.b2.hover.tl
                =event  "/click/set-window/{(trip u.sel)}/{seg-t}"
                ;+  ;/  seg-t
              ==
        ==
  ==
::
--
|%
::
+$  column       (list column-item)
+$  column-item  [fil=_| seg=term]
+$  column-data  (pair column column)
::
++  get-column-data
  |=  [sel=(unit term) sud=scud:mast]
  ^-  column-data
  =/  len  (lent pax.sud)
  =|  tem=column-item
  =;  a=column-data
    %_  a
      p  (flop p.a)
      q  (flop q.a)
    ==
  %+  roll  kid.sud
  |=  [paf=path acc=column-data]
  =.  paf  (slag len paf)
  ?~  paf  acc
  ?~  t.paf
    %_  acc
      p
        :_  p.acc
        %_  tem
          fil  &
          seg  i.paf
        ==
    ==
  ?:  ?&  ?=(^ p.acc)
          =(seg.i.p.acc i.paf)
      ==
    ?.  &(?=(^ sel) =(u.sel i.paf))  acc
    ?:  ?&  ?=(^ q.acc)
            =(seg.i.q.acc i.t.paf)
        ==
      acc
    %_  acc
      q
        :_  q.acc
        %_  tem
          fil  ?=(~ t.t.paf)
          seg  i.t.paf
        ==
    ==
  ?.  &(?=(^ sel) =(u.sel i.paf))
    %_  acc
      p
        :_  p.acc
        %_  tem
          seg  i.paf
        ==
    ==
  %_  acc
    p
      :_  p.acc
      %_  tem
        seg  i.paf
      ==
    q
      :_  q.acc
      %_  tem
        fil  ?=(~ t.t.paf)
        seg  i.t.paf
      ==
  ==
::
--

