class ExpandingTextarea extends HTMLElement {
  static formAssociated = true;

  static get observedAttributes() {
    return [
      'placeholder',
      'spellcheck',
      'autocomplete',
      'disabled',
      'required',
      'name',
    ];
  }

  constructor() {
    super();

    this.attachShadow({ mode: 'open' }).innerHTML = `
      <style>
        textarea {
          all: unset;
          width: 100%;
          display: block;
          resize: none;
          overflow-y: hidden;
          min-height: 1em;
          line-height: inherit;
          font: inherit;
          background: inherit;
          color: inherit;
          box-sizing: border-box;
        }

        textarea:disabled {
          opacity: 0.6;
          cursor: not-allowed;
        }
      </style>
      <textarea rows="1"></textarea>
      <slot hidden></slot>
    `;

    this.textarea = this.shadowRoot.querySelector('textarea');
    this.slot = this.shadowRoot.querySelector('slot');
    this._observer = new MutationObserver(() => this._syncValue());
    this._internals = this.attachInternals();

    this._resize = this._resize.bind(this);
    this._onKeydown = this._onKeydown.bind(this);
    this._onInput = this._onInput.bind(this);
  }

  connectedCallback() {
    this.textarea.addEventListener('input', this._onInput);
    this.textarea.addEventListener('keydown', this._onKeydown);
    this._observer.observe(this, {
      childList: true,
      subtree: true,
      characterData: true,
    });

    if (!this.hasAttribute('spellcheck')) this.setAttribute('spellcheck', 'false');
    if (!this.hasAttribute('autocomplete')) this.setAttribute('autocomplete', 'off');

    this._syncValue();
    this._reflectAttributes();
    this._validate();
  }

  disconnectedCallback() {
    this.textarea.removeEventListener('input', this._onInput);
    this.textarea.removeEventListener('keydown', this._onKeydown);
    this._observer.disconnect();
  }

  attributeChangedCallback() {
    this._reflectAttributes();
    this._validate();
  }

  _reflectAttributes() {
    this.textarea.placeholder = this.getAttribute('placeholder') || '';
    this.textarea.spellcheck = this.getAttribute('spellcheck') === 'true';
    this.textarea.autocomplete = this.getAttribute('autocomplete') || 'off';
    this.textarea.disabled = this.hasAttribute('disabled');
    this.textarea.required = this.hasAttribute('required');
  }

  _onInput() {
    this._internals.setFormValue(this.textarea.value);
    this._resize();
    this._validate();
  }

  _syncValue() {
    const text = this.textContent || '';
    this.value = text.trim();
    this._validate();
  }

  _resize() {
    const el = this.textarea;
    const container = el.closest('body') || window;
    const scrollTop = container.scrollTop;

    el.style.height = 'auto';
    el.style.height = Math.max(el.scrollHeight, 1) + 'px';

    container.scrollTop = scrollTop;
  }

  _onKeydown(event) {
    if ((event.metaKey || event.ctrlKey) && event.key === 'Enter') {
      const form = this.closest('form');
      if (form) {
        event.preventDefault();
        form.requestSubmit?.();
      }
    }
  }

  _validate() {
    const isRequired = this.hasAttribute('required');
    const isEmpty = this.value.trim() === '';

    if (isRequired && isEmpty) {
      this._internals.setValidity(
        { valueMissing: true },
        'This field is required.',
        this.textarea
      );
    } else {
      this._internals.setValidity({});
    }
  }

  // Form-associated element API
  get form() {
    return this._internals.form;
  }

  get name() {
    return this.getAttribute('name') || '';
  }

  get type() {
    return 'text';
  }

  get value() {
    return this.textarea.value;
  }

  set value(val) {
    this.textarea.value = val;
    this._internals.setFormValue(val);
    this._resize();
    this._validate();
  }

  focus() {
    this.textarea.focus();
  }

  formResetCallback() {
    this.value = '';
  }

  checkValidity() {
    return this._internals.checkValidity();
  }

  reportValidity() {
    return this._internals.reportValidity();
  }
}

customElements.define('expanding-textarea', ExpandingTextarea);
