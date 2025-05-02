/-  mast, athens
:-  ^-  boom:mast
    :*  %$
        %z
        !>(~)
    ==
=<
^-  mast:mast
|_  [=scud:mast =sack:mast]
::
++  spar
  |=  =crow:mast
  ^-  blow:mast
  =/  pol  ^-  (pole @ta)  path.crow
  ?+  pol  ~^~
    ::
      [%submit %post ~]
    =/  dat  (~(got by data.crow) 'post-input')
    ?:  =('' dat)  ~^~
    :_  ~
    :~  (make-action-card scud [%put-post ~ dat])
    ==
    ::
  ==
::
++  sail
  ^-  manx
  ;div.athens
    ;div.posts
      ;+  style
      ;*  %+  turn  kid.scud
          |=  p=path
          (make:mast %athens-post (weld pax.scud p) ~)
      ;form(event "/submit/post")
        ;input.post-input(name "post-input");
        ;button: Post
      ==
    ==
  ==
::
--
|%
::
++  make-action-card
  |=  [sud=scud:mast act=action:athens]
  ^-  card:agent:gall
  [%pass /athens-post %agent [our.sud %athens] %poke %athens-action !>(act)]
::
++  style
  ^-  manx
  ;style
    ;+  ;/  %-  trip
    '''
    @import url('https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Source+Code+Pro:ital,wght@0,200..900;1,200..900&display=swap');
    .post-input {
      margin-top: 3px;
      border-width: 1px;
      border-radius: 9px;
      border-style: solid;
      border-color: #575757;
    }
    .options {
      color: #A3A3A3;
    }
    .options > button {
      visibility: hidden;
      margin-inline: 0.2em;
    }
    .options:hover > button {
      visibility: visible;
    }
    .options > button:hover {
      color: #FAFAFA;
    }
    .athens {
      height: 100%;
      width: 100%;
      background: #0f0f0f;
      overflow-y: scroll;
    }
    .posts {
      padding: 150px 16px 400px 16px;
      margin: auto;
      width: 100%;
      max-width: 1000px;
      display: flex;
      flex-direction: column;
      gap: 16px;
    }
    .replies-container {
      margin-top: 0.6em;
    }
    .post-node-container {
      display: flex;
      flex-direction: column;
    }
    .post-container {
      display: flex;
      flex-direction: row;
      gap: 16px
    }
    .post {
      display: flex;
      gap: 16px;
    }
    .author {
      font-family: 'Source Code Pro', monospace;
      font-weight: 500;
      font-size: 14px;
      leading-trim: Cap height;
      line-height: 140%;
      letter-spacing: 0%;
      vertical-align: middle;
      color: #FAFAFA;
      min-width: 120px;
    }
    .message {
      flex-grow: 1;
      font-family: Inter, sans-serif;
      font-weight: 400;
      font-size: 14px;
      leading-trim: Cap height;
      line-height: 130%;
      letter-spacing: 0%;
      color: #A3A3A3;
      max-width: 645px;
      width: 100%;
      white-space: pre-line;
    }
    .message.full {
      
    }
    .message.full.reply {
      padding-left: 0.4em;
      border-left-width: 1px;
      border-left-color: #7d7d7d;
      border-left-style: solid;
    }
    .message.preview {
      display: flex;
      gap: 8px;
      flex-grow: 1;
    }
    .replies {
      padding-left: 0px;
    }
    '''
  ==
::
--

