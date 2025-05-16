|%
+$  action
  $%  [%put-post post-at=path content=@t]
      [%patch-post post-at=path content=@t]
      [%del-post at=path]
      [%access-public public=?]
      [%edit-access-id ids=(list @p)]
      [%del-access-id id=@p]
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
+$  access  
  $:  public=? 
      ids=(list @p)
  ==
::
+$  state
  $:  =posts
      =user-sessions
      =access
  ==
--

