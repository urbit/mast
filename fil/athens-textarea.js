class AthensTextarea extends HTMLElement {
  static formAssociated = true

  static get observedAttributes() {
    return ['value', 'preview-only', 'class']
  }

  constructor() {
    super()
    this._internals = this.attachInternals()

    this.container = document.createElement('div')
    this.container.className = 'athens-editor'

    this.tabContainer = document.createElement('div')
    this.tabContainer.className = 'tab-controls'

    this.writeTab = document.createElement('button')
    this.writeTab.type = 'button'
    this.writeTab.textContent = 'Write'
    this.writeTab.className = 'tab active'

    this.previewTab = document.createElement('button')
    this.previewTab.type = 'button'
    this.previewTab.textContent = 'Preview'
    this.previewTab.className = 'tab'

    this.tabContainer.append(this.writeTab, this.previewTab)

    this.textarea = document.createElement('textarea')
    this.textarea.rows = 1

    this.preview = document.createElement('div')
    this.preview.className = 'markdown-preview'
    this.preview.style.display = 'none'

    this.writeTab.addEventListener('click', () => this._setTab('write'))
    this.previewTab.addEventListener('click', () => this._setTab('preview'))

    this.textarea.addEventListener('input', () => {
      this._resize()
      this._internals.setFormValue(this.textarea.value)
      this.setAttribute('value', this.textarea.value)
    })

    this.textarea.addEventListener('keydown', (event) => {
      if (event.key === 'Enter' && !event.shiftKey) {
        event.preventDefault()
        const form = this.closest('form')
        if (form) form.requestSubmit()
      }
    })

    this.container.append(this.tabContainer, this.textarea, this.preview)
  }

  connectedCallback() {
    const style = document.createElement('style')
    style.textContent = `
      h1 {
        font-size: 48px;
        letter-spacing: 0.01em;
        line-height: 48px;
      }
      h2 {
        font-size: 30px;
      }
      h3 {
        font-size: 24px;
      }
      h4 {
        font-size: 20px;
      }
      h5 {
        font-size: 18px;
      }
      h6 {
        font-size: 14px;
      }
      .clamp-one-line h1,
      .clamp-one-line h2,
      .clamp-one-line h3,
      .clamp-one-line h4,
      .clamp-one-line h5,
      .clamp-one-line h6 {
        font-size: 14px;
        font-weight: 400px;
        line-height: 14px;
      }
      .clamp-one-line {
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: normal;
        max-width: 400px;
      }
      .tab-controls {
        display: flex;
      }
      .tab {
        padding: 8px 16px;
        font-size: 14px;
        border: none;
        background: none;
        cursor: pointer;
        outline: none;
      }
      .tab.active{
        background: #262626;
      }
      textarea {
        width: 100%;
        resize: none;
        font-size: 14px;
        border: none;
        box-sizing: border-box;
        font-family: inherit;
      }
      .markdown-preview {
        font-size: 14px;
      }
      `

    if (!this.contains(style)) {
      this.appendChild(style)
    }

    if (!this.contains(this.container)) {
      this.appendChild(this.container)
    }

    const classList = this.getAttribute('class')
    if (classList) {
      this.textarea.className =
        classList +
        ' focus:border rounded-[3px] focus:outline-none focus:border-white focus:ring-0'
      console.log(classList)
      if (this.classList.contains('hide')) {
        this.preview.classList.add('clamp-one-line')
      } else {
        this.preview.classList.remove('clamp-one-line')
      }
    }

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

    if (name === 'class') {
      this._updateClampState()
    }
  }

  _setTab(tab) {
    if (tab === 'write') {
      this.textarea.style.display = ''
      this.preview.style.display = 'none'
      this.writeTab.classList.add('active')
      this.previewTab.classList.remove('active')
    } else {
      this._renderMarkdown()
      this.textarea.style.display = 'none'
      this.preview.style.display = ''
      this.writeTab.classList.remove('active')
      this.previewTab.classList.add('active')
    }
  }

  _updatePreviewOnly() {
    const previewOnly = this.getAttribute('preview-only') === 'true'
    this.textarea.style.display = previewOnly ? 'none' : ''
    this.preview.style.display = previewOnly ? '' : 'none'
    this.tabContainer.style.display = previewOnly ? 'none' : ''
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

  _updateClampState() {
    if (this.classList.contains('hide')) {
      this.preview.classList.add('clamp-one-line')
    } else {
      this.preview.classList.remove('clamp-one-line')
    }
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
