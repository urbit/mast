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
  }

  createRenderRoot() {
    return this
  }

  render() {
    const isPreview = this.previewOnly || this.activeTab === 'preview'
    const clamp = this.classList.contains('hide') ? 'clamp-one-line' : ''

    return html`
      <div class="athens-editor flex items-start">
        ${isPreview
          ? html`<div
              class="markdown-preview ${clamp} prose prose-p:mb-0 prose-p:mt-0 inline-block translate-y-[-4px] align-top min-h-[16px]"
              id="preview"
            ></div>`
          : html`<textarea
              name=${this.textareaClass}
              style=${isPreview ? 'display: none;' : ''}
              class="${this
                .textareaClass} flex items-center min-h-[16px] w-full focus:text-white focus:outline-none leading-[16px] text-[16px] md:text-[14px] p-2 border-0 box-border text-sm shadow-none"
              rows="1"
              placeholder="Write something..."
              .value=${this.value}
              @input=${this._onInput}
              @keydown=${this._onKeydown}
            ></textarea>`}
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
    const scrollY = window.scrollY

    requestAnimationFrame(() => {
      window.scrollTo(0, scrollY)
    })
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
    if (!textarea || textarea.offsetParent === null) return // don't resize if hidden

    requestAnimationFrame(() => {
      textarea.style.height = 'auto'
      textarea.style.height = textarea.scrollHeight + 'px'
    })
  }

  _updatePreview() {
    const preview = this.querySelector('#preview')
    if (!preview || !window.marked) return

    window.marked.setOptions({ breaks: true })
    const trimValue = this.value.trimEnd()
    preview.innerHTML = window.marked.parse(trimValue)

    // Remove empty trailing paragraph if it exists
    const last = preview.lastElementChild
    if (last?.tagName === 'P' && !last.textContent.trim()) {
      last.remove()
    }

    if (this.classList.contains('hide')) {
      preview.style.height = '18px'
    } else {
      preview.style.height = 'auto'
      requestAnimationFrame(() => {
        const initialHeight = preview.offsetHeight
        preview.style.height = `${initialHeight - 4}px`
      })
    }
  }

  connectedCallback() {
    super.connectedCallback()

    if (this.previewOnly) {
      this.activeTab = 'preview'
    }

    this._classObserver = new MutationObserver((mutations) => {
      for (const m of mutations) {
        if (m.attributeName === 'class') {
          this._updatePreview()
          this.requestUpdate()
        }
      }
    })

    this._classObserver.observe(this, { attributes: true })

    const form = this.closest('form')

    this.addEventListener('focusin', () => {
      form?.classList.add('is-focused')
    })
    this.addEventListener('focusout', () => {
      form?.classList.remove('is-focused')
    })
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
