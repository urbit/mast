|%
+$  action
  $%  [%put-post post-at=path content=@t]
      [%patch-post post-at=path content=@t]
      [%del-post at=path]
      [%hide-post at=path]
      [%unhide-post at=path]
      [%set-access-mode mode=term]
      [%edit-access-id ids=(list @p)]
      [%del-access-id id=@p]
      ::
      [%gated-register id=@p door-code=@t]
      [%gated-sign-in id=@p]
      [%gated-set-door-code code=@t]
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
+$  user-session-0
  $:  hidden-posts=(set post-id)
      new-posts=(set path)
  ==
+$  user-session
  $:  hidden-posts=(set post-id)
      new-posts=(set path)
      selected-post=(unit path)
  ==
+$  user-sessions  (map @p user-session)
+$  access-0
  $:  public=?
      members=(list @p)
      blacklist=(list @p)
  ==
+$  access-mode  ?(%gated %private %public)
+$  access
  $:  mode=access-mode      :: we don't use $% here so that the
      ::                    ::   host can switch between modes
      ::                    ::   without losing data for other modes
      blacklist=(list @p)   :: if public
      members=(list @p)     :: if private
      accounts=(map @p @p)  :: if gated
      door-code=@t          :: if gated
  ==
--