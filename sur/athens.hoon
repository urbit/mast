|%
+$  action
  $%  [%put-post post-at=path content=@t]
      [%patch-post post-at=path content=@t]
      [%del-post at=path]
      [%hide-post at=path]
      [%unhide-post at=path]
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
      replies=posts-view
  ==
+$  posts-view
  %-  list
  %+  pair
      path
      view
+$  view
  $%  [%old ~]
      [%new ~]
      [%display-none ~]
      [%hidden [posts=@ud new-post-total=@ud]]
  ==
+$  user-sessions  (map @p user-session)
+$  user-session
  $:  hidden-posts=(set post-id)
      new-posts=(set path)
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

