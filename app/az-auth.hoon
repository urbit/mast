/+  moses
::
::  agent types
::
|%
+$  state-0
  $:  %state-0
      sessions=(map @uv @p)
  ==
+$  state-n  $%(state-0)
+$  card  card:agent:gall
--
::  agent
::
=|  state-n
=*  state  -
=<
^-  agent:gall
|_  =bowl:gall
+*  this  .
    cor  ~(. +> [bowl ~])
    ::
++  on-init
  ::
  ^-  (quip card _this)
  :_  this
  :~
    (bind-url dap.bowl /az-auth)
    (bind-url dap.bowl /moses)
  ==
  ::
  ::
++  on-save
  ::
  ^-  vase
  !>  state
  ::
++  on-load
  ::
  |=  =vase
  ^-  (quip card _this)
  ::
  =/  s=state-n
    %-  fall  :_  *state-0
    %-  mole  |.
    !<  state-0
    vase
  ::
  :_  this(state s)
  :: :_  this(state *state-n)
  :~
    (bind-url dap.bowl /az-auth)
    (bind-url dap.bowl /moses)
  ==
  ::
++  on-poke
  ::
  |=  [=mark =vase]
  ^-  (quip card _this)
  =^  cards  state  abet:(poke:cor mark vase)
  :-  cards  this
::
++  on-watch
  ::
  |=(path ^-((quip card _this) `this))
  ::
++  on-leave
  ::
  |=(path `this)
  ::
++  on-peek
  ::
  |=  =path
  ^-  (unit (unit cage))
  !!
  ::
++  on-agent
  ::
  |=  [wire sign:agent:gall]
  ^-  (quip card _this)
  `this
  ::
++  on-arvo
  ::
  |=  [=wire sign=sign-arvo]
  ^-  (quip card _this)
  =^  cards  state  abet:(arvo:cor wire sign)
  :-  cards  this
  ::
++  on-fail
  ::
  |=  [=term =tang]
  ^-  (quip card _this)
  %-  (slog term tang)
  `this
  ::
--
::
::  runner
::
|_  [=bowl:gall cards=(list card)]
++  cor   .
++  abet  [(flop cards) state]
++  emit  |=  =card  cor(cards [card cards])
++  emil  |=  caz=(list card)  cor(cards (welp (flop caz) cards))
++  our-ta  (scot %p our.bowl)
++  now-ta  (scot %da now.bowl)
++  bek  /[our-ta]/[q.byk.bowl]/[now-ta]
++  bak  |=  =desk  /[our-ta]/[desk]/[now-ta]
++  bem  |=  =path  (welp bek path)
++  bam  |=  [=desk =path]  (welp (bak desk) path)
::
+$  request-line
  ::
  $:  [ext=(unit @ta) site=(list @t)]
      args=(list [key=@t value=@t])
  ==
++  parse-request-line
  ::
  |=  url=@t
  ^-  request-line
  (fall (rush url ;~(plug apat:de-purl:html yque:de-purl:html)) [[~ ~] ~])
++  bind-url
  ::
  |=  [app=@tas url=path]
  ^-  card:agent:gall
  :*  %pass  /bind  %arvo  %e  %connect  [~ url]  app
  ==
  ::
++  make-http-cards
  ::
  |=  [rid=@ta hed=response-header.simple-payload:http dat=(unit octs)]
  ^-  (list card:agent:gall)
  :~  [%give %fact ~[/http-response/[rid]] [%http-response-header !>(hed)]]
      [%give %fact ~[/http-response/[rid]] [%http-response-data !>(dat)]]
      [%give %kick ~[/http-response/[rid]] ~]
  ==
  ::
++  poke
  |=  [=mark =vase]
  ^+  cor
  ?+  mark  ~|(bad-poke/mark !!)
    :::
    %handle-http-request
      =+  !<  [rid=@ta req=inbound-request:eyre]  vase
      =/  line  (parse-request-line url.request.req)
      =/  pams  ~(. by (malt args.line))
      ?+    route=((pole knot) site.line)
          ~|  no-route/site.line
          !!
        [%moses ~]
          %-  emil  %+  make-http-cards  rid
          moses
        [%az-auth ~]
          %-  emil  %+  make-http-cards  rid
          ^-  simple-payload:http
          :-  [200 ['content-type' 'text/html']~]
          %-  manx-body
          ;div
            ;h1: az-auth
          ==
        [%az-auth %'~' %logout ~]
          =/  sud  (session-id-from-request request.req)
          =?  sessions  ?=(^ sud)
            (~(del by sessions) u.sud)
          %-  emil  %+  make-http-cards  rid
          ^-  simple-payload:http
          :_  ~
          [307 ['location' '/az-auth']~]
        [%az-auth %'~' %login ~]
          %-  fall  :_
            %-  emil  %+  make-http-cards  rid
            ^-  simple-payload:http
            :-  [400 ['content-type' 'text/html']~]
            %-  manx-body
            ;div
              ;h2: not enough info given or token auth failed
              ;-  <line>
            ==
          %-  mole  |.
          =/  ship  (slav %p (got:pams 'ship'))
          =/  token  (slav %uv (got:pams 'token'))
          =/  message  ((pair @p @p) (cue token))
          ::
          ?.  ?&  =(p.message ~sampel-palnet)
                  =(q.message our.bowl)
              ==
            %-  emil  %+  make-http-cards  rid
            ^-  simple-payload:http
            :-  :-  403
                :~  ['content-type' 'text/html']
                ==
            %-  manx-body
            ;div
              ;div: invalid token
              ;-  <message>
            ==
          ::
          =/  redirect  (got:pams 'redirect')
          =/  skey  new-session-key
          =.  sessions  (~(put by sessions) skey ship)
          %-  emil  %+  make-http-cards  rid
          ^-  simple-payload:http
          :_  ~
          :-  307
          :~  ['content-type' 'text/html']
              ['location' redirect]
              :-  'set-cookie'
              (crip "az-auth-{(scow %p our.bowl)}={(scow %uv skey)}; Path=/; Max-Age=604800")
          ==
        [%az-auth slug=* *]
          %-  emil  %+  make-http-cards  rid
          =/  sud  (session-id-from-request request.req)
          =/  whu=(unit @p)
            ?~  sud  ~
            (~(get by sessions) u.sud)
          ?~  whu
            ^-  simple-payload:http
            :-  [403 ['content-type' 'text/html']~]
            %-  manx-body
            ;div
              ;h1: 403 unauthenticated
              ;a/"/az-auth": home
            ==
          =/  who=ship  u.whu
          ^-  simple-payload:http
          :-  [200 ['content-type' 'text/html']~]
          %-  manx-body
          ;div
            ;h1: forum: {(trip slug.route)}
            ;pre: {<who>}
            ;form(action "/az-auth/~/logout")
              ;button: logout
            ==
            ;div
              ## how it works

              it's like eauth.
              
              everything is still based
              on cookie sessions.

              cookie sessions can be initiated from the "offline dashboard".

              - the link on the "offline dashboard" contains
                - url = `host.domain/az-auth/~/login`
                - params
                  - ship = `<requesting-ship>`
                  - redirect = `/az-auth/<forum-slug>`
                  - token = `<authentication-token>`
                    - the message `[<requesting-ship> <host-ship>]` signed with
                      the requesting ship's networking key

              
              ## things still being faked

              - the signing!
                - currently, instead of signing, it just `+jam`s/`+cue`s the message
                - i'm sure it's possible, but i'm not yet sure how to
                  verify the signature of a ship that is not running
              - how to resolve a forum host's domain without an arvo
              
            ==
          ==
      ==
  ==
++  manx-body
  |=  =manx
  :-  ~
  %-  as-octt:mimes:html
  %-  en-xml:html
  ;html
    ;head
      ;meta(charset "UTF-8");
      ;title: athens with az-auth
    ==
    ;body:(+manx)
  ==
++  new-session-key
  |-  ^-  @uv
  =/  candidate=@uv  (~(raw og (shas %session-key eny.bowl)) 128)
  ?.  (~(has by sessions) candidate)
    candidate
  $(eny.bowl (shas %try-again candidate))
++  session-id-from-request
  |=  =request:http
  ^-  (unit @uv)
  ::  are there cookies passed with this request?
  ::
  =/  cookie-header=@t
    %+  roll  header-list.request
    |=  [[key=@t value=@t] c=@t]
    ?.  =(key 'cookie')
      c
    (cat 3 (cat 3 c ?~(c 0 '; ')) value)
  ::  is the cookie line valid?
  ::
  ?~  cookies=(rush cookie-header cock:de-purl:html)
    ~
  ::  is there an az-auth cookie?
  ::
  ?~  az-auth=(get-header:http (crip "az-auth-{(scow %p our.bowl)}") u.cookies)
    ~
  ::  if it's formatted like a valid session cookie, produce it
  ::
  `(unit @)`(rush u.az-auth ;~(pfix (jest '0v') viz:ag))
++  arvo
  ::
  |=  [wire=(pole knot) sign=sign-arvo]
  ^+  cor
  ?+  wire  ((slog >unkown-wire/wire< ~) cor)
    [%bind ~]   cor
  ==
--