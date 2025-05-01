/-  athens
|%
+$  card  card:agent:gall
+$  state-0  state:athens
+$  state-n
  $%  [%state-0 state-0]
  ==
--
::
=|  state-n
=*  state  -
=<
^-  agent:gall
|_  =bowl:gall
+*  this  .
    cor  ~(. +> [bowl ~])
::
++  on-init
  ^-  (quip card _this)
  :_  this
  ~
::
++  on-save
  ^-  vase
  !>  ~
::
++  on-load
  |=  =vase
  ^-  (quip card _this)
  :_  this
  ~
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  =^  cards  state  abet:(poke:cor mark vase)
  :-  cards  this
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  :: ~&  [%athens-watch path]
  :-  ~  this
::
++  on-leave  |=(path ^-((quip card _this) !!))
::
++  on-peek
  |=  pax=path
  ^-  (unit (unit cage))
  ?<  ?=(~ pax)
  ?+  +.pax  ~
    ::
    [%posts ~]
      ?+  i.pax  ~
        %t
          :^  ~  ~  %$  !>
          ^-  (list path)
          %+  turn  (tap:posts-on posts.state)
          |=  [k=post-id:athens v=post:athens]
          /[(scot %da k)]
      ==
    ::
    [%posts @ta ~]
      ?+  i.pax  ~
        %r
          :^  ~  ~  %$  !>
          =/  =post-id:athens  (slav %da i.t.t.pax)
          :: BUG: the mop got crashes sometimes, yet when I log it, the key is in the mop: (got:posts-on posts.state post-id)
          :: but the regular got always works
          =/  =post:athens  (~(got by posts.state) post-id)
          [%athens-post !>(post)]
        %t
          :^  ~  ~  %$  !>
          *(list path)
      ==
    ::
  ==
::
++  on-agent  |=([wire sign:agent:gall] ^-((quip card _this) !!))
++  on-arvo   |=([wire sign-arvo] ^-((quip card _this) !!))
++  on-fail   |=([term tang] ^-((quip card _this) !!))
--
::
|_  [=bowl:gall cards=(list card)]
++  cor   .
++  abet  :-  (flop cards)  state
++  emit  |=  =card  cor(cards [card cards])
++  emil  |=  caz=(list card)  cor(cards (welp (flop caz) cards))
::
++  poke
  |=  [=mark =vase]
  ^+  cor
  ?+  mark  ~|(bad-poke/mark !!) 
    ::
      %test-post
    =/  dat  !<  @t  vase
    %-  add-post  dat
    ::
  == 
::
++  add-post
  |=  dat=@t
  ^+  cor
  =/  =post:athens  [src.bowl dat ~]
  =/  =post-id:athens  now.bowl
  =.  posts  (~(put by posts) post-id post)
  %-  emit
  %-  make-fact-card  /t/posts
::
++  make-fact-card
  |=  =path
  ^-  card
  :*  %give  %fact  ~[path]  %noun  !>(~)
  ==
::
++  posts-on  ((on post-id:athens post:athens) lte)
::
--

