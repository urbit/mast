|%
+$  post-id  @da
+$  posts  ((mop post-id post) lte)
+$  post
  $~  [*@p *@t ~]
  $:  author=@p
      content=@t
      replies=posts
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

