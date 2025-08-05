/-  mast
/*  urbit-sigil  %js  /fil/urbit-sigil/js
/*  expanding-textarea  %js  /fil/expanding-textarea/js
^-  mast:mast
=<
:-  ~
|_  =hull:mast
++  spar  *$-(crow:mast blow:mast)
++  sail
  ^-  manx
  %-  document
  ?+  route=((pole @ta) rut.hull)
    not-found
  ::
      [~]
    %^  make:mast  %circles
      ~
    :~  [%id /id]
    ==
  ::
      [%recent ~]
    ;div: recent
  ::
      [id=* ~]
    ?~  when=(slaw %da id.route)  not-found
    %^  make:mast  %circles
      ~
    :~  [%id /id/[(scot %da u.when)]]
    ==
  ::
  ==
--
::
|%
::
++  not-found
  %^  make:mast  %athens-404  ~  ~
::
++  document
  |=  com=manx
  ^-  manx
  ;html
    ;head
      ;title: Circles
      ;meta(charset "UTF-8");
      ;meta(name "viewport", content "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no");
      ;link(rel "manifest", href "/apps/circles/manifest");
      ;link(rel "icon", href "/athens/favicon");
      ;link(rel "preconnect", href "https://fonts.googleapis.com");
      ;link(rel "preconnect", href "https://fonts.gstatic.com", crossorigin "");
      ;link(href "https://fonts.googleapis.com/css2?family=Fragment+Mono:ital@0;1&family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap", rel "stylesheet");
      ;script(src "https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4");
      ;script(src "https://cdn.jsdelivr.net/npm/marked/marked.min.js");
      ;script(type "module"): {(trip urbit-sigil)}
      ;script(type "module"): {(trip expanding-textarea)}
      ;style(type "text/tailwindcss")
        ;-  %-  trip
        '''
        @theme {
          --color-neutral-bg: #0f0f0f;
          --color-neutral-dim: #A3A3A3;
          --color-neutral-bright: #FAFAFA;
        }
        '''
      ==
      ;style: {(trip style)}
      ;script: {(trip script)}
    ==
    ;body
      =class  "bg-neutral-bg text-neutral-dim"
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
  .center-line, 
  .center-line-first,
  .center-line-last {
    position: relative;
    isolation: isolate;
  }
  .center-line::after {
    content: "";
    position: absolute;
    top: 0;
    bottom: 0;
    left: 50%;
    width: 1px;
    background: var(--grey-default);
    transform: translateX(-50%);
    z-index: -1;
    pointer-events: none;
  }
  .center-line-last::after {
    content: "";
    position: absolute;
    top: 0;
    bottom: calc(100% - 0.7em);
    left: 50%;
    width: 1px;
    background: var(--grey-default);
    transform: translateX(-50%);
    z-index: -1;
    pointer-events: none;
  }
  .center-line-first::after {
    content: "";
    position: absolute;
    top: 0.75em;
    bottom: 0;
    left: 50%;
    width: 1px;
    background: var(--grey-default);
    transform: translateX(-50%);
    z-index: -1;
    pointer-events: none;
  }
  .linkable a {
    text-decoration: underline;
  }
  textarea {  /* fix a safari textarea flickering */
    -webkit-overflow-scrolling: auto;
    transition: height 0s;
  }
  html {
    scroll-behavior: smooth;
  }
  body{
    font-family: Inter, sans-serif;
  }
  textarea {
    resize: none;
  }
  '''
++  script
  '''
  function linkify() {
    const divs = document.querySelectorAll('.linkable');
  
    const urlRegex = /(?:https?:\/\/[^\s<>"']+)/g;
  
    divs.forEach(div => {
      div.innerHTML = div.innerHTML.replace(urlRegex, url => {
        const escapedUrl = url.replace(/&/g, '&amp;')
                              .replace(/</g, '&lt;')
                              .replace(/>/g, '&gt;');
        return `<a href="${escapedUrl}" target="_blank" rel="noopener noreferrer">${escapedUrl}</a>`;
      });
    });
  }
  
  window.addEventListener('load', () => {
    linkify();
  });
  '''
--
