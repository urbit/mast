|%
+$  action
  $%  [%put-post post-at=path content=@t]
  ==
::
+$  post-id  @da
+$  posts  (map post-id post-node)
+$  post-node
  $~  [*post ~]
  $:  =post
      replies=posts
  ==
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

