/-  mast
::
=<
=/  info-card
  ::
  |=  [=path =cage]
  ^-  card:agent:gall
  =/  =soba:clay  [path %ins cage]~
  =/  =nori:clay  [%& soba] 
  =/  =task:clay  [%info %base nori]
  [%pass mast-ins/path %arvo %c task]
  ::
:-  ^-  boom:mast
    :*  %ttt
        %x
        !>(*flag)
    ==
^-  mast:mast
|_  [=scud:mast =sack:mast]
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ~&  event/-.crow
  ?+  -.crow  ~^~
    ::
      [%click %poll ~]
    :-  ~  !>
    ?:(!<(flag loc.sack) | &)
  ::
      [%click %reset ~]
    :_  loc.sack
    :~  (info-card pax.scud %ttt !>(*game))
    ==
    ::
      [%click %play ~]
    =/  newf  ?:(!<(flag loc.sack) | &)
    =/  r  (~(got by data.crow) '/target/data-row')
    =/  c  (~(got by data.crow) '/target/data-column')
    =/  gam  !<  game  fil.sack
    =.  gam
      %+  play  gam
      :-  ?:(=(0 (mod count.gam 2)) %x %o)
      ^-  place
      [(row r) (column c)]
    :_  !>(newf)
    :~  (info-card pax.scud %ttt !>(gam))
    ==
    ::
  ==
::
++  sail
  ^-  manx
  =/  loc  !<  flag  loc.sack
  =/  gam  !<  game  fil.sack
  =,  gam
  |^
    ;div.wf.hf.fc.g2.winter.b1.p3
      ;+  result
      ;+  print-board
      ;+  reset
    ==
  ++  print-board
    ;div.fc.g1.p4(key "ttt-board")
      ;*
      %+  turn
        ^-  (list (list place))
        :~
          ~[[%top %left] [%top %center] [%top %right]]
          ~[[%center %left] [%center %center] [%center %right]]
          ~[[%bottom %left] [%bottom %center] [%bottom %right]]
        ==
      |=  row=(list place)
      ;div.fr.g1
        =key  <row>
        ;*
        %+  turn  row
        |=  =place
        =/  puc=(unit piece)  (~(get by board) place)
        (print-btn place puc)
      ==
    ==
  ++  print-btn
    |=  [place =(unit piece)]
    ;button.p2.br1.bd1.b3.mono.s1
      =event  "/click/play"
      =return  "/target/data-row /target/data-column"
      =data-row  (trip row)
      =data-column  (trip column)
      =key  "{<column>}-{<row>}"
      ;+  ;/
      ?~  unit  "-"
      ?:  =(%o u.unit)  "o"
      "x"
    ==
  ++  reset
    ;button.b2.br1.bd1.p2.wfc(event "/click/reset", key "reset-blhkoh"): reset
  ++  result
    ?~  result.gam
      ;div(key "resyyyy");
    ;div.fr.ac.g4(key "resss")
      ;h2.s2: game over
      ;div: {<u.result.gam>}
    ==
  --
::
--
|%
+$  piece   ?(%x %o)
+$  row     ?(%top %center %bottom)
+$  column  ?(%left %center %right)
+$  place   [=row =column]
+$  board   (map place piece)
+$  move    [=piece =place]
+$  game    [=board count=@ud result=(unit ?(%draw piece))]
::  application engine
::
++  play
  |_  [game =move]
  ++  $
    ^-  game
    ?>  ?=(~ result)
    ?>  =(player piece.move)
    ?>  !(~(has by board) place.move)
    =+  (~(put by board) place.move piece.move)
    :+  -  +(count)
    ^-  (unit ?(%draw piece))
    =/  mine=(set place)
      %-  ~(rep by -)
      |=  [[=place =piece] acc=(set place)]
      ?.  =(piece piece.move)  acc
      (~(put in acc) place)
    ?:  %-  ~(any in lines)
        |=  s=(set place)
        =(~ (~(dif in s) mine))
      `piece.move
    ?.  =(8 ~(wyt by board))
      ~
    (some %draw)
  ++  player  ?:(=(0 (mod count 2)) %x %o)
  ++  lines  :: winning combinations
    ^-  (set (set place))
    %-  silt
    %-  turn  :_  silt
    ^-  (list (list place))
    :~  :: horizontal
        ~[[%top %left] [%top %center] [%top %right]]
        ~[[%center %left] [%center %center] [%center %right]]
        ~[[%bottom %left] [%bottom %center] [%bottom %right]]
        :: vertical
        ~[[%top %left] [%center %left] [%bottom %left]]
        ~[[%top %center] [%center %center] [%bottom %center]]
        ~[[%top %right] [%center %right] [%bottom %right]]
        :: diagonal
        ~[[%top %left] [%center %center] [%bottom %right]]
        ~[[%top %right] [%center %center] [%bottom %left]]
    ==
  --
--