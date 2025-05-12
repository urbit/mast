class AthensTextarea extends HTMLElement {
  static formAssociated = true

  static get observedAttributes() {
    return ['value']
  }

  constructor() {
    super()
    this._internals = this.attachInternals()

    this.textarea = document.createElement('textarea')
    this.textarea.rows = 1

    this.textarea.addEventListener('input', () => {
      this._resize()
      this._internals.setFormValue(this.textarea.value)
      this.setAttribute('value', this.textarea.value) // Keep attribute in sync
    })
  }

  connectedCallback() {
    if (!this.contains(this.textarea)) {
      this.appendChild(this.textarea)
    }

    const classList = this.getAttribute('class')
    if (classList) {
      this.textarea.className = classList
    }

    this.textarea.placeholder = 'Type something here...'

    // If a value attribute was passed, apply it
    if (this.hasAttribute('value')) {
      this.textarea.value = this.getAttribute('value')
      this._internals.setFormValue(this.textarea.value)
    }

    this._resize()
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (name === 'value' && this.textarea && newValue !== this.textarea.value) {
      this.textarea.value = newValue
      this._internals.setFormValue(newValue)
      this._resize()
    }
  }

  _resize() {
    this.textarea.style.height = 'auto'
    this.textarea.style.height = this.textarea.scrollHeight + 'px'
  }

  get value() {
    return this.textarea.value
  }

  set value(val) {
    this.textarea.value = val
    this.setAttribute('value', val) // Reflect to attribute
    this._internals.setFormValue(val)
    this._resize()
  }

  formAssociatedCallback() {}
  formDisabledCallback(disabled) {
    this.textarea.disabled = disabled
  }
  formResetCallback() {
    this.value = ''
  }
  formStateRestoreCallback(state) {
    this.value = state
  }
}

customElements.define('athens-textarea', AthensTextarea)
