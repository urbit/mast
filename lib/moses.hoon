::  a static html page root client, WIP
::
::
^-  simple-payload:http
:-  :-  200
    :~  ['content-type' 'text/html']
    ==
:-  ~
%-  as-octt:mimes:html
%-  en-xml:html
|^
%+  doc  "passkey test"
;div.fc.g3.p8.g8.ac.scroll-y.hf
  :::
  ::  login screen
  ::
  ;form.fc.wf.af.xw20.ma.hidden
    ::
    =data-signals-loading  "false"
    =data-signals-init  "false"
    =data-class-hidden  "$loading || $init"
    =data-signals-patp  "''"
    =data-signals-supercode  "''"
    =data-persist  "patp"
    =data-signals-haspasskey  "false"
    =data-on-submit  "loadWallet(ctx, $patp, $supercode)"
    ;input#patp-in.btlr2.btrr2.bd1.p-2.mono
      =placeholder  "ship name (@p)"
      =data-bind  "patp"
      =autocomplete  "off"
      =spellcheck  "false"
      =data-on-input  "$haspasskey = checkForPasskey($patp)"
      =data-custom-validity  "urbitKeyGeneration.ob.isValidPatp($patp) ? '' : 'invalid @p'"
      =required  ""
      ;
    ==
    ;div.fr.af.bdr1
      ;input#supercode-in.p-2.grow.mono.bdl1.w0
        =placeholder  "supercode (@q)"
        =data-bind  "supercode"
        =type  "password"
        =autocomplete  "webauthn"
        =data-custom-validity  "urbitKeyGeneration.ob.isValidPatq($supercode) ? '' : 'invalid @q'"
        =required  ""
        ;
      ==
      ;button.p-1.b1.hover.mono.fs-1.o5.bdl1
        =type  "button"
        =data-on-click  "fromPasskey(ctx, $patp, evt)"
        =data-show  "$haspasskey"
        =data-on-load  "$haspasskey = checkForPasskey($patp)"
        ; passkey
      ==
    ==
    ;button.bd1.b2.hover.p2.bbrr2.bblr2.mono.o7
      =type  "submit"
      ; login
    ==
  ==
  ::
  ::  loading screen
  ::
  ;div.p8.tc.mono.o5.fs1.hidden.ma.pre
    ::
    =data-class-hidden  "!$loading"
    ; building
    ;  wallet
    ;   ....
  ==
  ::
  ::  dashboard ahh yeall yeah
  ::
  ;div.fc.g4.wf.af.hidden.mw-page
    =data-class-hidden  "$loading || !$init"
    ::
    ::  metadata
    ::
    ;div.frw.g3.as
      ::
      ;div.wfc.fc.ac.jc.bd1.br3.p2.b1.winter
        ;div.br1
          =data-ref-sigil  ""
          ;
        ==
        ;div
          =data-on-signal-change-patp  "setSigil($sigil, $patp)"
          =data-on-load  "setSigil($sigil, $patp)"
          ;
        ==
        ;div.mono.f2.o6(data-text "$patp");
      ==
      ;div.fc.g2.grow
        ;details.br1.bd1
          ;summary.fr.p2.br1.b1.hover: reveal supercode
          ;div.p3(data-text "$supercode");
        ==
        ;div.frw.g2
          ;button.p-1.br1.bd1.b1.hover
            =data-on-click  "createPasskey();  $haspasskey = checkForPasskey($patp)"
            =data-show  "!$haspasskey"
            ; create passkey
          ==
          ;button.p-1.br1.bd1.b1.hover
            =data-on-click  "encryptSupercode(ctx, $patp, $supercode);  $haspasskey = checkForPasskey($patp)"
            =data-show  "!$haspasskey"
            ; encrypt supercode with passkey
          ==
          ;button.p-1.br1.bd1.b1.hover
            =data-on-click  "localStorage.removeItem(`passkey-$\{$patp}`); $haspasskey = checkForPasskey($patp)"
            =data-show  "$haspasskey"
            ; remove passkey
          ==
        ==
      ==
    ==
    ::
    ::  links
    ::
    ::  xx
    ::    use real encryption/signing
    ::
    ;div.fc.p3.g2
      ;h2.p2: Athens
      ;*
      ::
      ::
      %+  turn
        ^-  (list [tape tape ship tape])
        :~
          ["Loose Motions" "loose-motions" ~sorreg-namtyv "https://sorreg-namtyv.tlon.io"]
          ["Honk, Honk" "honk-honk" ~lonhep-migrev-dolseg "http://localhost"]
        ==
      |=  [name=tape slug=tape host=ship url=tape]
      =/  token=tape
        ::  XX not a real signed token!!
        %+  scow  %uv
        (jam [~sampel-palnet host])
      ;a.br1.bd1.p-2.b1.hover.fc
        =target  "_blank"
        =href  "{url}/az-auth/~/login".
               "?redirect=/az-auth/{slug}".
               "&ship=~sampel-palnet".
               "&token={token}"
        ;div.fr.jb.ac
          ;span.bold: {name}
          ;span.mono.f4.fs-1: {(cite:title host)}
        ==
        ;div.o5.fs-1: {url}
      ==
    ==
    ::
    ::  accounts
    ::
    ;div.fc.p3.g2
      ::
      ;+  %-  render-account
          %*  .  *account
            type  "ownership"
          ==
      ;+  %-  render-account
          %*  .  *account
            type  "management"
          ==
      ;+  %-  render-account
          %*  .  *account
            type  "transfer"
          ==
      ;+  %-  render-account
          %*  .  *account
            type  "spawn"
          ==
    ==
    ::
    ::  logout button
    ::
    ;button.p-1.br1.bd1.b1.hover.wfc.f4.ma.o8
      ::
      =data-on-click  "$supercode = ''; $init = false;"
      ; logout
    ==
  ==
  ::
  ;style
    ::
    ;-  %-  trip
    '''
    #patp-in:invalid,
    #supercode-in:invalid {
      color: orange;
    }
    '''
  ==
  ;script
    ::
    ;-  %-  trip
    '''
    function setSigil(ref, ship) {
      try {
        ref.innerHTML = sigil.sigil({
          point: ship,
          foreground: 'currentColor',
          background: 'var(--b1)',
        })
      } catch(e) {
        
      }
    }

    function checkForPasskey(ship) {
      return !!localStorage.getItem(`passkey-${ship}`)
    }
    const loadWallet = (ctx, shipText, ticket) => {
      ctx.signals.setValue('loading', true);
      ctx.signals.setValue('init', true);

      setTimeout(
        () => {
          loadWalletReal(ctx, shipText, ticket);
        }, 2
      )
    }
    const loadWalletReal = async (ctx, shipText, ticket) => {
      
      let wallet = await urbitKeyGeneration.generateWallet({
        ship: urbitKeyGeneration.ob.patp2dec(shipText),
        ticket
      })

      let accounts = ['ownership', 'spawn', 'transfer', 'management'];
      accounts.forEach(a => {
        $(`.${a}-derivation`).text(wallet[a].derivationPath)
        $(`.${a}-seed`).text(wallet[a].seed)
        $(`.${a}-address`).text(wallet[a].keys.address)
        $(`.${a}-chain`).text(wallet[a].keys.chain)
        $(`.${a}-private`).text(wallet[a].keys.private)
        $(`.${a}-public`).text(wallet[a].keys.public)
      })
      
      ctx.signals.setValue('loading', false);
    }

    async function encrypt(plaintext, secret) {
      const enc = new TextEncoder();
    
      const salt = crypto.getRandomValues(new Uint8Array(16));
      const iv = crypto.getRandomValues(new Uint8Array(12));
    
      const keyMaterial = await crypto.subtle.importKey(
        "raw", enc.encode(secret), { name: "PBKDF2" }, false, ["deriveKey"]
      );
    
      const key = await crypto.subtle.deriveKey(
        {
          name: "PBKDF2",
          salt: salt,
          iterations: 100000,
          hash: "SHA-256"
        },
        keyMaterial,
        { name: "AES-GCM", length: 256 },
        false,
        ["encrypt"]
      );
    
      const ciphertext = await crypto.subtle.encrypt(
        { name: "AES-GCM", iv: iv },
        key,
        enc.encode(plaintext)
      );
    
      // Combine salt + iv + ciphertext
      const combined = new Uint8Array(salt.length + iv.length + ciphertext.byteLength);
      combined.set(salt, 0);
      combined.set(iv, salt.length);
      combined.set(new Uint8Array(ciphertext), salt.length + iv.length);
    
      return btoa(String.fromCharCode(...combined));
    }

    async function decrypt(encryptedBase64, secret) {
      const enc = new TextEncoder();
      const dec = new TextDecoder();
    
      const combined = Uint8Array.from(atob(encryptedBase64), c => c.charCodeAt(0));
      const salt = combined.slice(0, 16);
      const iv = combined.slice(16, 28);
      const ciphertext = combined.slice(28);
    
      const keyMaterial = await crypto.subtle.importKey(
        "raw", enc.encode(secret), { name: "PBKDF2" }, false, ["deriveKey"]
      );
    
      const key = await crypto.subtle.deriveKey(
        {
          name: "PBKDF2",
          salt: salt,
          iterations: 100000,
          hash: "SHA-256"
        },
        keyMaterial,
        { name: "AES-GCM", length: 256 },
        false,
        ["decrypt"]
      );
    
      const decrypted = await crypto.subtle.decrypt(
        { name: "AES-GCM", iv: iv },
        key,
        ciphertext
      );
    
      return dec.decode(decrypted);
    }
    
    async function computeSHA256(message) {
      const encoder = new TextEncoder();
      const data = encoder.encode(message);
      const hashBuffer = await crypto.subtle.digest('SHA-256', data);
      const hashArray = Array.from(new Uint8Array(hashBuffer));
      const hashHex = hashArray
        .map((b) => b.toString(16).padStart(2, '0'))
        .join('');
      return hashHex;
    }
    
    function stringToUint8Array(str) {
      const encoder = new TextEncoder();
      return encoder.encode(str);
    };
    
    function arrayBufferToString(buffer, encoding = 'utf-8') {
      const decoder = new TextDecoder(encoding);
      const view = new Uint8Array(buffer);
      return decoder.decode(view);
    }
    
    function createUser(p) {
      return ({
        id: stringToUint8Array(p),
        name: p,
        displayName: p,
      })
    }
    const urbitChallenge = stringToUint8Array('urbit-deadbeef');
    
    // navigator.credentials.get({
    //   mediation: "conditional",
    //   publicKey: { challenge: urbitChallenge }
    //   });
      
    async function createPasskey() {
      let credential = await navigator.credentials.create({
        publicKey: {
          challenge: urbitChallenge,
          user: createUser('urbit'),
          rp: { id: "localhost", name: "Urbit" },
          pubKeyCredParams: [{ type: "public-key", alg: -7 }],
        },
      });
    }
    
    async function encryptSupercode(ctx, ship, supercode) {
      let credential = await navigator.credentials.get({
        publicKey: { challenge: urbitChallenge }
      });
      
      let symkey = await computeSHA256(credential.response.signature)
      let keyname = await computeSHA256(symkey)

      let keypath = `passkey-${ship}`
      let encrypted = await encrypt(supercode, symkey)
      localStorage.setItem(keypath, encrypted)
      ctx.signals.setValue('haspasskey', true)
    }
    
    async function fromPasskey(ctx, ship, evt) {
      let publicKey = { challenge: urbitChallenge }
      let credential = await navigator.credentials.get({
        publicKey
      });
      
      let symkey = await computeSHA256(credential.response.signature)
      let keyname = await computeSHA256(symkey)

      let keypath = `passkey-${ship}`
      let encrypted = localStorage.getItem(keypath)

      if (!encrypted) {
        alert(`no supercode stored for: ${ship}`)
        return;
      }

      let decrypted = await decrypt(encrypted, symkey)
      
      ctx.signals.setValue('supercode', decrypted)

      let f = evt.target.closest('form').querySelector('button[type=submit]').click()
      f?.submit();
    }
    '''
  ==
==
::
++  render-pair  render-label-pair
++  render-label-pair
  ::
  |=  [id=tape label=tape value=tape]
  ;div.break
    ;span.bold.mono.f5: {label} 
    ;span(class "break-all {id}"): {value}
  ==
::
+$  account
  ::
  $:
    type=tape
    derivation=tape
    seed=tape
    keys=keys
  ==
+$  keys
  ::
  $:
    address=tape
    chain=tape
    private=tape
    public=tape
  ==
::
++  render-account
  ::
  |=  =account
  ;details.bd1.br2
    =id  type.account
    ;summary.bd1.br2.p-2.b1.hover.fr
      ;span.o5: {type.account} account
      :: ;span(class "break-all {type.account}-address"): {address.keys.account}
    ==
    ;div.p3.fc.g1
      ;div.p3.fs3.bold
        ; $0
      ==
      ;+  %^  render-pair
              "{type.account}-address"
            "address"
          address.keys.account
      ;+  %^  render-pair
              "{type.account}-derivation"
            "derivation"
          derivation.account
      ;+  %^  render-pair
              "{type.account}-chain"
            "chain"
          chain.keys.account
      ;+  %^  render-pair
              "{type.account}-public"
            "public key"
          public.keys.account
      ;details.br1.bd1
        ;summary.br1.bd1.b1.hover.p-2.fr.f3: secrets
        ;div.p3
          ;+  %^  render-pair
                  "{type.account}-private"
                "private key"
              private.keys.account
          ;+  %^  render-pair
                  "{type.account}-seed"
                "seed"
              seed.account
          ==
        ==
    ==
  ==
++  doc
  |=  [title=tape body=manx]
  ;html
    ;meta(charset "UTF-8");
    ;title:(-title)
    :: urbit-key-generation
    ::
    ;script(src "https://nyc3.digitaloceanspaces.com/drain/hawk/1746751853615.js");
    ::
    :: sigil-js
    ::
    ;script(src "https://nyc3.digitaloceanspaces.com/drain/hawk/1746770665186.js");
    ::
    :: data-star
    ::
    ;script(type "module", src "https://cdn.jsdelivr.net/gh/starfederation/datastar@v1.0.0-beta.11/bundles/datastar.js");
    ::
    :: jquery
    ::
    ;script(src "https://code.jquery.com/jquery-3.7.1.slim.min.js");
    ::
    :: feather
    ::
    ;link(rel "stylesheet", href "https://nyc3.digitaloceanspaces.com/drain/hawk/1750091621623.css");
    ;body
      ;+  body
    ==
  ==
++  aatt
  ::
  |=  [name=cord val=tape m=manx]
  ^-  manx
  m(a.g [[name val] a.g.m])
--