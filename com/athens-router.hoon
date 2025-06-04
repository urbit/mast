/-  mast
/*  athens-textarea-litdev  %js  /fil/athens-textarea-litdev/js
/*  footnote-parser  %js  /fil/footnote-parser/js
^-  mist:mast
=<
|=  =keel:mast
?+  url.keel  not-found
  ::
  ~  main-thread
  ::
==
::
|%
::
++  main-thread
  %-  document
  %^  make:mast  mast/%athens  ~
  :~  [%posts /athens/posts]
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
      ;script(src "https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4");
      ;script(src "https://cdn.jsdelivr.net/npm/marked/marked.min.js");
      ;script(type "module"): {(trip footnote-parser)}
      ;script(type "module"): {(trip athens-textarea-litdev)} 
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
    top: 15;
    right: 30;
    padding-block: 0.2em;
    padding-inline: 0.3em;
    color: #A3A3A3;
    font-weight: 500;
    font-size: 14px;
  }
  .user.open{
    left: 15;
    width: 100%;
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
    border-left-width: 1px;
    border-left-color: #575757;
    border-left-style: solid;
  }
  .replies-container {
    display: flex;
    flex-direction: column;
    gap: 16px;
  }
  .replies {
    padding-left: 0px;
  }
  .reply-num{
    color: #737373;
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
    margin-top: 0.45em;
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
  athens-textarea-litdev .tab-controls {
    display: flex;
  }
  athens-textarea-litdev .tab {
    padding: 8px 16px;
    font-size: 14px;
    border: none;
    background: none;
    cursor: pointer;
    outline: none;
  }
  athens-textarea-litdev .tab.active {
    background: #262626;
  }
  athens-textarea-litdev textarea {
    width: 100%;
    resize: none;
    border: none;
    box-sizing: border-box;
    font-family: inherit;
  }
  athens-textarea-litdev .markdown-preview {
    font-size: 14px;
  }
  athens-textarea-litdev .clamp-one-line {
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: normal;
  }
  athens-textarea-litdev textarea{
    background: #0f0f0f;
    border-radius: 10px;
  }
  athens-textarea-litdev .clamp-one-line h1,
  athens-textarea-litdev .clamp-one-line h2,
  athens-textarea-litdev .clamp-one-line h3,
  athens-textarea-litdev .clamp-one-line h4,
  athens-textarea-litdev .clamp-one-line h5,
  athens-textarea-litdev .clamp-one-line h6 {
    font-size: 14px;
    font-weight: 400;
    line-height: 1.5;
  }
  athens-textarea-litdev .clamp-one-line table {
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
  athens-textarea-litdev .clamp-one-line tbody {
    display: none;
  }
  .prose.clamp-one-line td, 
  athens-textarea-litdev .prose.clamp-one-line th {
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
  @media (min-width: 768px) {
    .author {
      margin-left: 0 !important;
    }
  }
  '''
::
--

