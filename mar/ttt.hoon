::  tic-tac-toe state machine
::  an experiment in the namespace
::
!:
=<
::
::  boilerplate mark core
::
|_  rot=rock
++  grab  :: from
  |%
  ++  noun  rock
  ++  mime
    |=  (pair mite octs)
    :: ?>  ?=([%text %ttt ~] p)
    =/  =wain  (to-wain:format q.q)
    =/  =wall  (turn wain trip)
    =/  look
      |=  [r=@ c=@]
      ^-  (unit piece)
      %-  mole  |.
      =/  rr=tape  (snag r wall)
      =/  cc=cord  (snag c rr)
      ?:  =('x' cc)  %x
      ?:  =('o' cc)  %o
      !!
    =/  pet
      |=  [b=board =place =(unit piece)]
      ^-  board
      ?~  unit  b
      (~(put by b) place u.unit)
    =|  =rock
    =.  board.rock  (pet board.rock [%top %left] (look 0 0))
    =.  board.rock  (pet board.rock [%top %center] (look 0 1))
    =.  board.rock  (pet board.rock [%top %right] (look 0 2))
    =.  board.rock  (pet board.rock [%center %left] (look 1 0))
    =.  board.rock  (pet board.rock [%center %center] (look 1 1))
    =.  board.rock  (pet board.rock [%center %right] (look 1 2))
    =.  board.rock  (pet board.rock [%bottom %left] (look 2 0))
    =.  board.rock  (pet board.rock [%bottom %center] (look 2 1))
    =.  board.rock  (pet board.rock [%bottom %right] (look 2 2))
    rock
  ++  txt
    |=  =wain
    =/  =wall  (turn wain trip)
    =/  look
      |=  [r=@ c=@]
      ^-  (unit piece)
      %-  mole  |.
      =/  rr=tape  (snag r wall)
      =/  cc=cord  (snag c rr)
      ?:  =('x' cc)  %x
      ?:  =('o' cc)  %o
      !!
    =/  pet
      |=  [b=board =place =(unit piece)]
      ^-  board
      ?~  unit  b
      (~(put by b) place u.unit)
    =|  =rock
    =.  board.rock  (pet board.rock [%top %left] (look 0 0))
    =.  board.rock  (pet board.rock [%top %center] (look 0 1))
    =.  board.rock  (pet board.rock [%top %right] (look 0 2))
    =.  board.rock  (pet board.rock [%center %left] (look 1 0))
    =.  board.rock  (pet board.rock [%center %center] (look 1 1))
    =.  board.rock  (pet board.rock [%center %right] (look 1 2))
    =.  board.rock  (pet board.rock [%bottom %left] (look 2 0))
    =.  board.rock  (pet board.rock [%bottom %center] (look 2 1))
    =.  board.rock  (pet board.rock [%bottom %right] (look 2 2))
    rock
  --
++  grow  :: to 
  |%
  ++  txt
    ^-  wain
    %+  turn  (limo %top %center %bottom ~)
    |=  r=row
    %-  crip
    %+  turn  (limo %left %center %right ~)
    |=  c=column
    =/  p=(unit piece)  (~(get by board.rot) [r c])
    ?~  p  '.'
    ?:  =(%x u.p)  'x'
    'o'
  ++  noun  rot
  ++  mime
    :-  /text/ttt
    %-  as-octt:mimes:html
    %-  of-wall:format
    %+  turn  (limo %top %center %bottom ~)
    |=  r=row
    ^-  tape
    %+  turn  (limo %left %center %right ~)
    |=  c=column
    =/  p=(unit piece)  (~(get by board.rot) [r c])
    ?~  p  '.'
    ?:  =(%x u.p)  'x'
    'o'
  --
++  grad  %mime
::  |%
::  ++  form  %noun
::  ++  diff  |=(* ~)
::  ++  pact  wash
::  ++  join  |=(* ~)
::  ++  mash  |=(* !!)
::  --
--
::
=< 
::
::  lake from sss.hoon
::
|%
+$  rock  game
+$  wave  move
++  wash  play
--
::
::  state machine core
::
|%
+$  piece   ?(%x %o)
+$  row     ?(%top %center %bottom)
+$  column  ?(%left %center %right)
+$  place   [=row =column]
+$  board   (map place piece)
+$  move    [=piece =place]
+$  game    [=board count=@ud result=(unit ?(%draw piece))]
++  rows  (limo [%top %center %bottom ~])
++  columns  (limo [%left %center %right ~])
::
::  application engine
::
++  play
  |_  [game =move]
  ++  $
    ^-  game
    ?<  ?|  !=(~ result)
            !=(player piece.move)
            (~(has by board) place.move)
            ==
    =+  (~(put by board) place.move piece.move)
    :+  -  +(count)
    ^+  result
    =/  mine=(set place)
      %-  ~(rep by -)
      |=  [[=place =piece] acc=(set place)]
      ?.  =(piece piece.move)  acc
      (~(put in acc) place)
    ?:  %-  ~(any in lines)
        |=  s=(set place)
        =(~ (~(dif in mine) s))
      (some piece.move)
    ?.  =(9 ~(wyt by board))
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
