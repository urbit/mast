/-  mast
^-  mast:mast
=<
:-  ~
|_  =hull:mast
::
++  spar  *$-(crow:mast blow:mast)
::
++  sail
  ^-  manx
  ?+  rut.hull
    ::
    not-found
    ::
    ~  main-thread
    ::
  ==
--
::
  ::
::
|%
::
++  main-thread
  ;html
    ;head;
    ;body
      ;+  %^  make:mast  mast/%athens
          ~
          :~  [%posts /athens/posts]
          ==
    ==
  ==
::
++  not-found
  ;html
    ;head;
    ;body
      ;+  (make:mast mast/%athens-404 ~ ~)
    ==
  ==
::
--

