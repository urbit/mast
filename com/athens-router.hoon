/-  mast
/*  athens-textarea-litdev  %js  /fil/athens-textarea-litdev/js
/*  athens-preview  %js  /fil/athens-preview/js
/*  footnote-parser  %js  /fil/footnote-parser/js
/*  scroll  %js  /fil/scroll/js
^-  mast:mast
=<
:-  ~
|_  =hull:mast
++  spar  *$-(crow:mast blow:mast)
++  sail
  ^-  manx
  ?+  rut.hull  not-found
    ::
    ~  main-thread
    ::
  ==
--
::
|%
::
++  main-thread
  %-  document
  %^  make:mast  mast/%athens  ~
  :~  [%posts /athens/posts-all]
      [%access /athens/access]
  ==
::
++  not-found
  %-  document
  %^  make:mast  mast/%athens-404  ~  ~
::
++  document
  |=  com=manx
  ^-  manx
  ;html
    ;head
      ;title: Athens
      ;meta(charset "UTF-8");
      ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ;link(rel "manifest", href "/athens/manifest");
      ;link(rel "preconnect", href "https://rsms.me/");
      ;link(rel "stylesheet", href "https://rsms.me/inter/inter.css");
      ;script(src "https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4");
      ;script(src "https://cdn.jsdelivr.net/npm/marked/marked.min.js");
      ;script(type "module"): {(trip footnote-parser)}
      ;script(type "module"): {(trip athens-textarea-litdev)} 
      ;script(type "module"): {(trip athens-preview)} 
      ;script(defer ""): {(trip scroll)}
      ;script(src "https://unpkg.com/lucide@latest");
      ;script:  lucide.createIcons();
      ;style(type "text/tailwindcss")
        ;-  %-  trip
        '''
        @theme {
          --color-neutral-bg: #0f0f0f;
          --color-neutral-400: #A3A3A3;
        }
        '''
      ==
      ;style: {(trip style)}
    ==
    ;body
    =class  "bg-neutral-bg text-neutral-400 athens ".
            "overflow-hidden"
      ;+  com
    ==
  ==
::
++  style
  '''
  html {
    scroll-behavior: smooth;
  }
  body{
    overflow-x: hidden;
    font-family: Inter, sans-serif;
  }
  .options {
    color: #A3A3A3;
  }
  .options > button {
    color: #A3A3A3;
    margin-inline: 0.25em;
    font-family: Inter, sans-serif;
    font-size: 0.85rem;
  }
  .post-container:hover > .options{
    visibility: visible;
  }
  .options > button:hover {
    color: #FAFAFA;
  }
  .login-link {
    margin-right: 0.2em;
    color: #FAFAFA;
  }
  .user {
    font-family: 'Fragment Mono', monospace;
    font-weight: 500;
    font-size: 14px;
    leading-trim: Cap height;
    line-height: 140%;
    letter-spacing: 0%;
    top: 24px;
    right: 24px;
    padding-block: 0.2em;
    padding-inline: 0.3em;
    color: #A3A3A3;
  }
  .user.open{
    left: 15;
    width: 100%;
  }
  .athens {
    height: 100%;
    width: 100%;
    overflow-y: scroll;
  }
  .posts {
    padding: 110px 16px 110px 16px;
    margin: auto;
    width: 100%;
    max-width: 1000px;
    display: flex;
    flex-direction: column;
  }
  .author {
    font-family: 'Fragment Mono', monospace;
    font-weight: 500;
    font-size: 14px;
    leading-trim: Cap height;
    line-height: 140%;
    letter-spacing: 0%;
    vertical-align: middle;
    color: #FAFAFA;
  }
  .author.hide {
    color: #737373;
  }
  .message {
    font-family: Inter, sans-serif;
    font-weight: 400;
    font-size: 14px;
    leading-trim: Cap height;
    line-height: 130%;
    letter-spacing: 0%;
    color: #A3A3A3;
  }
  .message.hide {
    color: #737373;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
  .message.reply {
    padding-left: 8px;
  }
  .replies-container {
    display: flex;
    flex-direction: column;
    gap: 16px;
  }
  .border-left,
  .form-post-wrapper{
    font-weight: 500;
    font-size: 14px;
  }
  .border-left{
    font-family: 'Fragment Mono', monospace;
    leading-trim: Cap height;
    line-height: 140%;
    letter-spacing: 0%;
    left: calc(var(--depth, 0px));
  }
  .replies {
    padding-left: 0px;
  }
  .reply-num{
    color: #737373;
    font-size: 14px;
    width: 7ch;
  }
  .reply-num.full{
    display: none;
  }
  .reply-num.hide{
    display: flex;
  }
  .reply-date.full{
    display: none;
  }
  .reply-date.hide{
    display: flex;
    color: #737373;
    font-size: 14px;
  }
  .form-border {
    border: 1px solid #575757;
    border-radius: 6px;
  }
  .post-reply-form {
    line-height: normal;
  }
  .post-form {
    line-height: normal;
  }
  .post-form.login-block {
    -webkit-user-select: none;
    -ms-user-select: none;
    user-select: none;
    justify-content: center;
    font-family: Inter, sans-serif;
    font-size: 0.85rem;
  }
  .post-form > button:hover {
    color: #FAFAFA;
  }
  .reply-button:hover{
    padding: 0.15em;
    border: solid;
    border-width: 1px;
    border-radius: 6px;
    border-color: #2C2C2C;
    background-color: #2C2C2C;
  }
  athens-textarea-litdev .tab-controls,
  athens-preview .tab-controls {
    display: flex;
  }
  athens-textarea-litdev .tab,
  athens-preview .tab {
    padding: 8px 16px;
    font-size: 14px;
    border: none;
    background: none;
    cursor: pointer;
    outline: none;
  }
  athens-textarea-litdev .tab.active,
  athens-preview .tab.active {
    background: #262626;
  }
  athens-textarea-litdev textarea {
    width: 100%;
    resize: none;
    border: none;
    box-sizing: border-box;
    font-family: inherit;
  }
  athens-preview .markdown-preview {
    font-size: 14px;
  }
  athens-preview .clamp-one-line,
  athens-preview .clamp-one-line * {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
  athens-textarea-litdev textarea{
    background: #0f0f0f;
    border-radius: 10px;
  }
  athens-preview .clamp-one-line * {
    font-size: 14px !important;
    font-weight: 400 !important;
    line-height: 1.5 !important;
    color: #737373 !important;
  }
  athens-preview .clamp-one-line p {
    white-space: nowrap;
    text-overflow: ellipsis;
    display: block;
    overflow: hidden;
  }
  athens-preview .clamp-one-line table {
    font-size: 14px;
    font-weight: 400;
    line-height: 1.5;
    display: inline;
    border: none;
  }
  athens-textarea-litdev .clamp-one-line pre {
    font-size: 14px;
    font-weight: 400;
    line-height: 1.5;
    display: inline;
    border: none;
    color: #737373;
  }
  athens-preview .clamp-one-line tbody {
    display: none;
  }
  .prose.clamp-one-line td, 
  athens-preview .prose.clamp-one-line th {
    display: inline;
    padding: 0;
    background: none;
    border: none;
    color: #737373;
  }
  .prose h1, h2, h3, h4, h5, h6 {
    margin: 1rem 0;
    font-size: 14px;
    font-weight: bold;
  }
  .prose h1 {
    font-size: 16px
  }
  .prose h1:first-child, h2:first-child, h3:first-child, h4:first-child, h5:first-child, h6:first-child,
  .prose h1:last-child, h2:last-child, h3:last-child, h4:last-child, h5:last-child, h6:last-child {
    margin: 0;
  }
  .prose p {
    margin: 1rem 0;
  }
  .prose p:last-child,
  .prose p:first-child {
    margin: 0;
  }
  .prose ul {
    list-style-type: disc;
    padding-left: 1.5rem; /* match Tailwind's pl-6 */
  }
  .prose ol {
    list-style-type: decimal;
    padding-left: 1.5rem;
  }
  .prose pre,
  .prose code {
    background: transparent;
    color: #FAFAFA;
    padding: 1rem; /* p-4 */
    border-radius: 0.5rem; /* rounded-lg */
    overflow-x: auto;
  }
  .prose table {
    font-family: Inter, sans-serif;
    border: 1px solid #A3A3A3;
    border-radius: 0.5rem;
    margin-top: 8px;
    margin-bottom: 8px;
  }
  .prose th {
    text-align: left;
    font-family: Inter, sans-serif;
    font-weight: normal;
    padding: 16px;
    color: #A3A3A3;
    border-bottom: 1px solid #A3A3A3;
  }
  .prose td {
    font-family: Inter, sans-serif;
    padding: 16px;
    color: #FAFAFA;
    border-bottom: 1px solid #A3A3A3;
  }
  .prose tr:last-child td {
    border-bottom: none;
  }
  .prose sup.footnote {
    font-size: 0.75em;
    color: #A3A3A3;
  }
  .prose a {
    text-decoration: underline;
  }
  .grid > div:nth-last-child(-n+3) {
    margin-bottom: 0; /* Remove bottom margin for last item */
  }
  @keyframes textFade {
      0%, 100% {
        color: #ffffff;
      }
      100% {
        color: #A3A3A3;
      }
    }
    .text-fade {
      animation: textFade 1s ease-in-out forwards;
    }
  @media (min-width: 768px) {
    .author {
      margin-left: 0 !important;
    }
    .border-left{
      left: calc(15ch + 16px + var(--depth, 0px));
    }
    .spacing-left{
      left: calc(15ch + 32px);
    }
  }
  '''
::
--

