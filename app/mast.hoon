/+  mast
/~  com  mast:mast  /com
::
::
::
::
|%
+$  state-0  *
+$  state-n
  $%  [%state-0 state-0]
  ==
+$  card  card:agent:gall
--
::
::
::
::
::
=|  state-n
=*  state  -
=<
^-  agent:gall
|_  =bowl:gall
+*  this  .
    cor  ~(. helper [bowl state])
++  on-init
  ^-  (quip card _this)
  :_  this
  :~  (bind-url:mast dap.bowl /mast)
  ==
++  on-save
  ^-  vase
  !>  ~
++  on-load
  |=  =vase
  ^-  (quip card _this)
  :_  this(state *state-n)
  :~  (bind-url:mast dap.bowl /mast)
  ==
++  on-poke
  |=  [=mark =vase]
  =+  (poke:cor mark vase)
  [-.- this(state +.-)]
++  on-watch  |=(path ^-((quip card _this) `this))
++  on-leave  |=(path ^-((quip card _this) !!))
++  on-peek   |=(path ^-((unit (unit cage)) !!))
++  on-agent  |=([wire sign:agent:gall] ^-((quip card _this) !!))
++  on-arvo   |=([wire sign-arvo] ^-((quip card _this) !!))
++  on-fail   |=([term tang] ^-((quip card _this) !!))
--
::
::
::
::
|%
++  helper
  |_  [=bowl:gall state=state-n]
  ++  our-ta  (scot %p our.bowl)
  ++  now-ta  (scot %da now.bowl)
  ++  bek  /[our-ta]/[q.byk.bowl]/[now-ta]
  ++  bak  |=  =desk  /[our-ta]/[desk]/[now-ta]
  ++  bem  |=  =path  (welp bek path)
  ++  bam  |=  [=desk =path]  (welp (bak desk) path)
  ::
  ::
  ++  poke
    |=  [=mark =vase]
    ~&  mast-with-components+~(wyt by com)
    ?+    mark
        ~|(bad-poke/mark !!) 
      %noun
        [~ state]
      ::
    ==
  --
--