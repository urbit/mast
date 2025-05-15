class AthensTextarea extends HTMLElement {
  static formAssociated = true

  static get observedAttributes() {
    return ['value', 'preview-only'] // Add preview-only to observed attributes
  }

  constructor() {
    super()
    this._internals = this.attachInternals()

    this.textarea = document.createElement('textarea')
    this.textarea.rows = 1
    // this.textarea.classList = 'focus:border-white focus:ring-0'

    this.preview = document.createElement('div')
    this.preview.className = 'markdown-preview'
    this.preview.style.marginTop = '1rem'
    this.preview.style.fontSize = '14px'

    this.textarea.addEventListener('input', () => {
      this._resize()
      this._internals.setFormValue(this.textarea.value)
      this.setAttribute('value', this.textarea.value)
      this._renderMarkdown()
    })
  }

  connectedCallback() {
    const style = document.createElement('style')
    style.textContent = `
      h1 {
        font-size: 2.5rem;
      }
      h2 {
        font-size: 2rem;
      }
      h3 {
        font-size: 1.75rem;
      }
      h4 {
        font-size: 1.5rem;
      }
      h5 {
        font-size: 1.25rem;
      }
      h6 {
        font-size: 1rem;
      }
    `
    if (!this.contains(style)) {
      this.appendChild(style)
    }
    if (!this.contains(this.textarea)) {
      this.appendChild(this.textarea)
    }
    if (!this.contains(this.preview)) {
      this.appendChild(this.preview)
    }

    const classList = this.getAttribute('class')
    if (classList) {
      this.textarea.className =
        classList +
        ' focus:border rounded-[3px] focus:outline-none focus:border-white focus:ring-0'
    }

    this.textarea.placeholder = 'Write something...'

    if (this.hasAttribute('value')) {
      this.textarea.value = this.getAttribute('value')
      this._internals.setFormValue(this.textarea.value)
    }

    this._updatePreviewOnly()
    this._resize()
    this._renderMarkdown()
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (name === 'value' && this.textarea && newValue !== this.textarea.value) {
      this.textarea.value = newValue
      this._internals.setFormValue(newValue)
      this._resize()
      this._renderMarkdown()
    }

    if (name === 'preview-only') {
      this._updatePreviewOnly()
    }
  }

  _updatePreviewOnly() {
    const previewOnly = this.getAttribute('preview-only') === 'true'
    this.textarea.style.display = previewOnly ? 'none' : ''
    this.preview.style.marginTop = previewOnly ? '0' : '1rem'
  }

  _resize() {
    this.textarea.style.height = 'auto'
    this.textarea.style.height = this.textarea.scrollHeight + 'px'
  }

  _renderMarkdown() {
    const raw = this.textarea.value
    const html = window.marked.parse(raw)
    this.preview.innerHTML = html
  }

  get value() {
    return this.textarea.value
  }

  set value(val) {
    this.textarea.value = val
    this.setAttribute('value', val)
    this._internals.setFormValue(val)
    this._resize()
    this._renderMarkdown()
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
