|%
+$  action
  $%  [%create-post parent=path content=@t]
      [%edit-post at=path content=@t]
      [%delete-post at=path]
      [%mark-read at=path]
      [%mark-unread at=path]
      [%set-user-position at=path]
      [%set-access-mode mode=term]
      [%edit-access-id ids=(list @p)]
      [%del-access-id id=@p]
      ::
      [%initialize-user ~]
      ::
      [%gated-sign-in comet=@p id=@p]
      [%gated-set-door-code code=@t]
  ==
::
+$  posts  (axal post)
+$  post
  $:  author=@p
      content=@t
  ==
+$  post-id  @da
+$  index  (map post-id path)  :: resolves post-id to its path
+$  user-session
  $:  new-posts=(set path)
      error=(unit tang)
  ==
+$  user-sessions  (map @p user-session)
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