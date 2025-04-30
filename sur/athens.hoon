|%
+$  post-id  @da
+$  posts  ((mop post-id post) lte)
+$  post
  $:  author=@p
      content=@t
  ==
+$  user-sessions  (map @p user-session)
+$  user-session
  $:  read-posts=(set post-id)
  ==
::
+$  state
  $:  =posts
      =user-sessions
  ==
--

