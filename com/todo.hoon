/-  mast
::
=<

:-  ^-  boom:mast
    :*  %todo
        %x
        !>(*flag)
    ==
^-  mast:mast
|_  [=scud:mast =sack:mast]
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  ?+  -.crow  ~^~
    ::
    ::
      [%input %save-flag ~]
    =/  todos  !<  todos  fil.sack
    =/  index  (slav %ud (~(got by data.crow) '/target/index'))
    =/  old=todo  (snag index todos)
    =/  =flag  .=  'true'  (~(got by data.crow) (crip "/target/checked"))
    =/  updated  (snap todos index [flag q.old])
    :_  loc.sack
    :~  (info-card pax.scud %todo !>(updated))
    ==
      [%click %save-cord ~]
    =/  todos  !<  todos  fil.sack
    =/  index  (slav %ud (~(got by data.crow) '/target/index'))
    =/  old=todo  (snag index todos)
    =/  new=todo
      :-  p.old
      (~(got by data.crow) (crip "/todo-{<index>}/value"))
    =/  updated  (snap todos index new)
    :_  loc.sack
    :~  (info-card pax.scud %todo !>(updated))
    ==
      [%click %delete ~]
    =/  todos  !<  todos  fil.sack
    =/  index  (slav %ud (~(got by data.crow) '/target/index'))
    =/  updated  (oust [index 1] todos)
    :_  loc.sack
    :~  (info-card pax.scud %todo !>(updated))
    ==
      [%submit %new ~]
    =/  todos  !<  todos  fil.sack
    =/  new=todo  [| (~(got by data.crow) 'new')]
    :_  loc.sack
    :~  (info-card pax.scud %todo !>([new todos]))
    ==
    ::
  ==
::
++  sail
  ^-  manx
  =/  fil  !<  (list (pair flag cord))  fil.sack
  |^
    ;div.grow.p-page.fc.g4.b1.winter
      ;h2: todo list
      ;div.fc.g2.mw-page
        ;*
        =;  =marl
          ?^  marl  marl
          ;=
            ;div.p5.o5: none yet
          ==
        =<  p
        %^  spin  fil  0
        |=  [=todo a=@]
        :_  +(a)
        (print-todo todo a)
      ==
      ;+  add-todo
    ==
  ++  print-todo
    |=  [[=flag =cord] i=@]
    ;div.fr.g2.ac
      =key  "todos-{<i>}"
      ;label.fr.g1
        ;span.o5: {<+(i)>}
        ;+
          =;  m=manx
            ?.  flag  m
            m(a.g [[%checked ""] a.g.m])
          ;input.s2
            =type  "checkbox"
            =event  "/input/save-flag"
            =index  (scow %ud i)
            =return  "/target/checked /target/index"
            ;
          ==
        ==
      ;input.br1.bd1.p-1.grow
        =id  "todo-{<i>}"
        =return  "/target/index"
        =type  "text"
        =value  (trip cord)
        =autocomplete  "off"
        =spellcheck  "false"
        ;
      ==
      ;button.br1.bd1.p-1.b2.hover.wfc
        =event  "/click/save-cord"
        =index  (scow %ud i)
        =return  "/todo-{<i>}/value /target/index"
        ; save
      ==
      ;button.br1.bd1.p-1.b2.hover.wfc
        =event  "/click/delete"
        =index  (scow %ud i)
        =return  "/target/index"
        ; x
      ==
    ==
  ++  add-todo
    ;form.fr.g1.mw-page
      =event  "/submit/new"
      ;input.br1.bd1.p-1.grow
        =name  "new"
        =placeholder  "new todo"
        =autocomplete  "off"
        =spellcheck  "false"
        =required  ""
        ;
      ==
      ;button.br1.bd1.p-1: new
    ==
  --
::
--
|%
+$  todo  (pair flag cord)
+$  todos  (list (pair flag cord))
++  info-card
  |=  [=path =cage]
  ^-  card:agent:gall
  =/  =soba:clay  [path %ins cage]~
  =/  =nori:clay  [%& soba] 
  =/  =task:clay  [%info %base nori]
  [%pass mast-ins/path %arvo %c task]
  ::
--