/-  mast
/*  athens-textarea-litdev  %js  /fil/athens-textarea-litdev/js
/*  athens-preview  %js  /fil/athens-preview/js
/*  footnote-parser  %js  /fil/footnote-parser/js
/*  scroll  %js  /fil/scroll/js
/*  urbit-sigil  %js  /fil/urbit-sigil/js
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
      ;meta(name "viewport", content "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no");
      ;link(rel "manifest", href "/athens/manifest");
      ;link(rel "preconnect", href "https://rsms.me/");
      ;link(rel "stylesheet", href "https://rsms.me/inter/inter.css");
      ;link(rel "preconnect", href "https://fonts.googleapis.com");
      ;link(rel "preconnect", href "https://fonts.gstatic.com", crossorigin "");
      ;link(href "https://fonts.googleapis.com/css2?family=Fragment+Mono:ital@0;1&family=Oswald:wght@200..700&display=swap", rel "stylesheet");
      ;script(src "https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4");
      ;script(src "https://cdn.jsdelivr.net/npm/marked/marked.min.js");
      ;script(type "module"): {(trip footnote-parser)}
      ;script(type "module"): {(trip athens-textarea-litdev)} 
      ;script(type "module"): {(trip athens-preview)} 
      ;script(type "module"): {(trip urbit-sigil)}
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
  :root{
    --bg-color: #0F0F0F;
    --grey-light: #A3A3A3;
    --grey-default: #737373;
    --text-color: #FAFAFA;
  }
  html {
    scroll-behavior: smooth;
  }
  body{
    overflow-x: hidden;
    font-family: Inter, sans-serif;
  }
  .gradient-top{
  background: linear-gradient(0deg, rgba(15, 15, 15, 0.00) 0%, var(--bg-color) 32.21%);
  height: 69px;
  }
  .gradient-bottom{
  background: linear-gradient(180deg, rgba(15, 15, 15, 0.00) 0%, var(--bg-color) 27.4%);
  height: 88px;
  max-height: 57vh;
  }
  .tracker > span {
    leading-trim: both;
    text-edge: cap;
    font-family: Inter, sans-serif;
    font-size: 14px;
    font-weight: 400;
    line-height: 1;
  }
  .options {
    color: var(--grey-light);
  }
  .options > div,
  .options > button {
    color: var(--grey-light);
    font-family: Inter, sans-serif;
    font-size: 14px;
  }
  .post-container:hover > .options{
    visibility: visible;
  }
  .options > div:hover,
  .options > button:hover {
    color: var(--text-color);
  }
  .login-link {
    margin-right: 0.2em;
    color: var(--text-color);
  }
  .user {
    font-size: 14px;
    leading-trim: Cap height;
    line-height: 140%;
    letter-spacing: 0%;
    top: 24px;
    right: 24px;
    color: var(--grey-light);
  }
  .user.open{
    left: 15;
    width: 100%;
  }
  .user .patp{
    font-family: 'Fragment Mono', monospace;
    font-weight: 400;
    color: var(--grey-light);
  }
  .athens {
    height: 100%;
    width: 100%;
    overflow-y: scroll;
  }
  .posts {
    padding: 110px 16px 180px 16px;
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
    color: var(--text-color);
  }
  .author.hide {
    color: var(--grey-default);
  }
  .message {
    font-family: Inter, sans-serif;
    font-weight: 400;
    font-size: 14px;
    leading-trim: Cap height;
    line-height: 130%;
    letter-spacing: 0%;
    color: var(--grey-light);
  }
  .message.hide {
    color: var(--grey-default);
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
    font-family: 'Fragment Mono', monospace;
    font-weight: 400;
    font-size: 14px;
  }
  .post-form{
    font-family: Inter, sans-serif;
  }
  .border-left{
    leading-trim: Cap height;
    line-height: 140%;
    letter-spacing: 0%;
    left: calc(var(--depth, 0px));
    z-index: 10;
  }
  .replies {
    padding-left: 0px;
  }
  .reply-num{
    color: var(--grey-default);
    font-size: 14px;
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
    color: var(--grey-default);
    font-size: 14px;
  }
  .form-reply-text{
    font-size: 14px;
    font-weight: 400;
    font-family: Inter, sans-serif;
    }
  .form-wrapper-border,
  .form-reply,
  .form-border {
    border: 1px solid var(--grey-default);
    border-radius: 4px;
  }
  .form-wrapper-border{
    border-bottom: 0;
  }
  .form-reply{
    border-right:0;
    border-left: 0;
  }
  .post-reply-form {
    font-family: Inter, sans-serif;
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
    color: var(--text-color);
  }
  athens-textarea-litdev .tab-controls,
  athens-preview .tab-controls {
    display: flex;
  }
  athens-preview pre {
    overflow-x: auto;
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
    background: var(--bg-color);
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
    word-break: break-word;
  }
  athens-textarea-litdev textarea{
    background: var(--bg-color);
    border-radius: 4px;
  }
  athens-preview .clamp-one-line * {
    font-size: 14px !important;
    font-weight: 400 !important;
    color: var(--grey-default) !important;
  }
  athens-preview .clamp-one-line table {
    font-size: 14px;
    font-weight: 400;
    display: inline;
    border: none;
  }
  athens-textarea-litdev .clamp-one-line pre,
  athens-textarea-litdev .clamp-one-line code{
    font-size: 14px;
    font-weight: 400;
    display: inline;
    border: none;
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
    color: var(--grey-default);
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
    color: var(--text-color);
    padding: 0.5rem; /* p-4 */
    border-radius: 0.5rem; /* rounded-lg */
    overflow-x: auto;
  }
  .prose table {
    font-family: Inter, sans-serif;
    border: 1px solid var(--grey-light);
    border-radius: 0.5rem;
    margin-top: 8px;
    margin-bottom: 8px;
  }
  .prose th {
    text-align: left;
    font-family: Inter, sans-serif;
    font-weight: normal;
    padding: 16px;
    color: var(--grey-light);
    border-bottom: 1px solid var(--grey-light);
  }
  .prose td {
    font-family: Inter, sans-serif;
    padding: 16px;
    color: var(--text-color);
    border-bottom: 1px solid var(--grey-light);
  }
  .prose tr:last-child td {
    border-bottom: none;
  }
  .prose sup.footnote {
    font-size: 0.75em;
    color: var(--grey-light);
  }
  .prose a {
    text-decoration: underline;
  }
  .grid > div:nth-last-child(-n+3) {
    margin-bottom: 0;
  }
  .target{
    background: #1E1F1E;
    box-sizing: border-box;
    padding: 8px 0; 
    margin: -8px 0; 
  }
  urbit-sigil {
    cursor: pointer;
  }
  @keyframes textFade {
      0%, 100% {
        color: var(--text-color);
      }
      100% {
        color: var(--grey-light);
      }
    }
    .text-fade {
      animation: textFade 3s ease-in-out forwards;
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
    .user .patp{
      color: var(--grey-default);
    }
  }
  @media (hover: hover) {
  .menu:hover > #settings-menu {
    display: flex !important;
  }
  .user:hover .patp{
      color: var(--grey-light);
    }
  }
  '''
::
--
