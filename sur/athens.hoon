|%
+$  action
  $%  [%put-post post-at=path content=@t]
      [%del-post at=path]
      [%hide-post id=post-id]
      [%unhide-post id=post-id]
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
+$  post-view
  $:  post
      replies=(list path)
  ==
+$  user-sessions  (map @p user-session)
+$  user-session
  $:  hidden-posts=(set post-id)
  ==
::
+$  state
  $:  =posts
      =user-sessions
  ==
--

