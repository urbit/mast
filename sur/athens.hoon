|%
+$  action
  $%  [%put-post post-at=path content=@t]
      [%patch-post post-at=path content=@t]
      [%del-post at=path]
      [%hide-post at=path]
      [%hide-all bundles=(list @da)]
      [%unhide-post at=path]
      [%unhide-bundles dat=date-type at=path]
      [%set-user-position at=path]
      [%set-access-mode mode=term]
      [%edit-access-id ids=(list @p)]
      [%del-access-id id=@p]
      ::
      [%gated-sign-in comet=@p id=@p]
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
+$  date-type  ?(%day %week %month %year)
+$  view
  $%  [%old selected=?]
      [%new selected=?]
      [%display-none ~]
      [%hidden [posts=@ud new-post-total=@ud selected=?]]
      [%hid-old [=date-type posts=@ud new-post-total=@ud oldest=@da]]
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
+$  user-sessions-0  (map @p user-session-0)
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