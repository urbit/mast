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
      ;form.post-form(event "/submit/post")
        ;textarea(name "post-input");
        ;button: 🠊
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
    .options {
      color: #A3A3A3;
    }
    .options {
      /* margin-left: auto; */
    }
    .options > button {
      visibility: hidden;
      color: #A3A3A3;
      margin-inline: 0.25em;
      font-family: Inter, sans-serif;
      font-size: 0.85rem;
    }
    .post-container:hover > .options > button {
      visibility: visible;
    }
    .options > button:hover {
      color: #FAFAFA;
    }
    .athens {
      height: 100%;
      width: 100%;
      /* background: #0f0f0f; */
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
    .author.hide {
      color: #575757;
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
    .message.hide {
      color: #575757;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .message.reply {
      padding-left: 0.3em;
      border-left-width: 1px;
      border-left-color: #575757;
      border-left-style: solid;
    }
    .replies-container {
      margin-top: 6px;
      display: flex;
      flex-direction: column;
      gap: 6px;
    }
    .replies {
      padding-left: 0px;
    }
    .post-form {
      width: 100%;
      margin-top: 0.45em;
      padding: 0.15em;
      border: solid;
      border-width: 1px;
      border-radius: 6px;
      border-color: #575757;
      display: flex;
    }
    .post-form > textarea {
      color: #FAFAFA;
      height: 1.5em;
      min-height: 1.5em;
      padding-inline: 0.3em;
      padding-top: 0.1em;
      resize: block;
      flex-grow: 1;
      font-size: 0.85rem;
      font-family: Inter, sans-serif;
    }
    .post-form > button {
      padding-inline: 0.2em;
      color: #A3A3A3;
    }
    .post-form > button:hover {
      color: #FAFAFA;
    }
    '''
  ==
::
--

