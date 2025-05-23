import {
  LitElement,
  html
} from 'https://cdn.jsdelivr.net/gh/lit/dist@3/core/lit-core.min.js'

class AthensTextareaLitdev extends LitElement {
  static formAssociated = true
  internals

  static properties = {
    value: { type: String, reflect: true },
    activeTab: { type: String },
    previewOnly: { type: Boolean, attribute: 'preview-only' },
    textareaClass: { type: String }
  }

  constructor() {
    super()
    this.internals = this.attachInternals()
    this.value = ''
    this.previewOnly = false
    this.activeTab = 'write'
  }

  createRenderRoot() {
    return this
  }

  render() {
    const isPreview = this.previewOnly || this.activeTab === 'preview'
    const clamp = this.classList.contains('hide') ? 'clamp-one-line' : ''

    return html`
      <div class="athens-editor">
        <textarea
          style=${isPreview ? 'display: none;' : ''}
          class="${this
            .textareaClass} focus:border rounded-[3px] focus:outline-none focus:border-white focus:ring-0 mt-auto"
          rows="1"
          placeholder="Write something..."
          .value=${this.value}
          @input=${this._onInput}
          @keydown=${this._onKeydown}
        ></textarea>
        <div
          style=${!isPreview ? 'display: none;' : ''}
          class="markdown-preview ${clamp} prose"
          id="preview"
        ></div>
      </div>
    `
  }

  firstUpdated() {
    const textarea = this.querySelector('textarea')
    if (textarea) {
      this._resize(textarea)
    }
  }

  updated(changed) {
    if (changed.has('value')) {
      const textarea = this.querySelector('textarea')
      if (textarea) {
        this._resize(textarea)
      }
      this._updatePreview()
    }
  }

  _onInput(e) {
    this.value = e.target.value
    this.internals.setFormValue(this.value)
    this._resize(e.target)
  }

  _onKeydown(e) {
    const isMobile = /Mobi|Android|iPhone|iPad|iPod/i.test(navigator.userAgent)

    if (!isMobile && e.key === 'Enter' && !e.shiftKey) {
      this.internals.setFormValue(this.value)
      e.preventDefault()
      this.closest('form')?.requestSubmit()
    }
  }

  _setTab(tab) {
    this.activeTab = tab

    const textarea = this.querySelector('textarea')
    if (textarea) {
      requestAnimationFrame(() => this._resize(textarea))
    }
  }

  _resize(textarea) {
    textarea.style.height = 'auto'
    textarea.style.height = textarea.scrollHeight + 'px'
  }

  _updatePreview() {
    const preview = this.querySelector('#preview')
    if (preview && window.marked) {
      window.marked.setOptions({ breaks: true })
      preview.innerHTML = window.marked.parse(this.value)
    }
  }
  connectedCallback() {
    super.connectedCallback?.()

    this._classObserver = new MutationObserver((mutations) => {
      for (const m of mutations) {
        if (m.attributeName === 'class') {
          this.requestUpdate() // Triggers re-render when class changes
        }
      }
    })

    this._classObserver.observe(this, { attributes: true })
  }

  disconnectedCallback() {
    this._classObserver?.disconnect()
  }

  // Form callbacks
  formAssociatedCallback() {}
  formDisabledCallback(disabled) {
    const textarea = this.querySelector('textarea')
    if (textarea) textarea.disabled = disabled
  }
  formResetCallback() {
    this.value = ''
    this.internals.setFormValue('')
  }
  formStateRestoreCallback(state) {
    this.value = state
  }
}

customElements.define('athens-textarea-litdev', AthensTextareaLitdev)
