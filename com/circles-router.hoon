/-  mast
/*  urbit-sigil  %js  /fil/urbit-sigil/js
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
  :: :root{
  ::   --bg-color: #0F0F0F;
  ::   --grey-light: #A3A3A3;
  ::   --grey-default: #737373;
  ::   --text-color: #FAFAFA;
  :: }
  '''
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
  function resizeTextarea(el) {
    // store scroll position to avoid a scroll flicker bug
    const container = el.closest('body') || window;
    const scrollTop = container.scrollTop;
    
    el.style.overflowY = 'hidden'
    el.style.height = 'auto';
    let newHeight = Math.max(el.scrollHeight, 15);
    el.style.height = newHeight + 'px';

    container.scrollTop = scrollTop;

  }
  function resizeBoxes() {
    document.querySelectorAll('textarea').forEach(autoResize);
  }
  function autoResize(el) {
    resizeTextarea(el);
    setTimeout(() => {resizeTextarea(el)}, 10);
  }
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
  
  document.addEventListener('input', (e) => {
    if (e.target.tagName === 'TEXTAREA') autoResize(e.target);
  });
  
  document.addEventListener('keydown', (e) => {
    if (e.target.tagName === 'TEXTAREA') {
      if (e.key == 'Enter' && (e.metaKey || e.ctrlKey)) {
        e.target?.form?.requestSubmit()
      }
    } else if (e.target.tagName === 'INPUT') {
      if (e.key == 'Enter' && (e.metaKey || e.ctrlKey)) {
        e.target?.form?.requestSubmit()
      } else if (e.key == 'Enter' && e.target.classList.contains('subject')) {
        e.preventDefault();
        e.stopPropagation();
        let message = e.target.nextElementSibling?.focus()
      }
    } else if (e.key ==  ' ') {
      e.preventDefault();
      e.stopPropagation();
      document.getElementById('next-new')?.click()
    }
  });
  
  window.addEventListener('load', () => {
    document.querySelectorAll('textarea').forEach(autoResize);
    linkify();
  });
  '''
--
