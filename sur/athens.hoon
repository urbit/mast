|%
+$  action
  $%  [%put-post post-at=path content=@t]
      [%patch-post post-at=path content=@t]
      [%del-post at=path]
      [%hide-post id=post-id]
      [%unhide-post id=post-id]
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
+$  post-view
  $:  post
      replies=(list path)
  ==
+$  user-sessions  (map @p user-session)
+$  user-session
  $:  hidden-posts=(set post-id)
  ==
+$  access  
  $:  public=? 
      members=(list @p)
      blacklist=(list @p)
  ==
+$  access  
  $:  public=? 
      members=(list @p)
      blacklist=(list @p)
  ==
::
+$  state
  $:  =posts
      =user-sessions
      =access
  ==
--

