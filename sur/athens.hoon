|%
+$  action
  $%  [%put-post post-at=path content=@t]
      [%patch-post post-at=path content=@t]
      [%del-post at=path]
      [%access-public public=?]
      [%edit-access-id ids=(list @p)]
      [%del-access-id id=@p]
      [%hide-post post=post-id]
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
      hidden-posts=(set post-id)
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
::
+$  post-prop
  $%
      [%hide ~]           :: not dispaly post component at all 
      [%join data=tape]   :: display data about hidden posts
      [%show ~]           :: display post-component
  ==
::
--

