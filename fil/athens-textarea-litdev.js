import {
  LitElement,
  html
} from 'https://cdn.jsdelivr.net/gh/lit/dist@3/core/lit-core.min.js'

class AthensTextareaLitdev extends LitElement {
  static formAssociated = true
  internals

  static properties = {
    name: { type: String },
    value: { type: String, reflect: true },
    activeTab: { type: String },
    textareaClass: { type: String }
  }

  constructor() {
    super()
    this.internals = this.attachInternals()
    this.value = ''
  }

  createRenderRoot() {
    return this
  }

  render() {
    const placeholderText =
      this.name === 'reply-input' ? 'Reply' : 'Write something...'
    return html`
      <div class="athens-editor flex items-start">
        <textarea
          name=${this.textareaClass}
          class="${this
            .textareaClass} flex items-center min-h-[16px] h-[0px] w-full focus:text-white focus:outline-none leading-[16px] text-[16px] md:text-[14px] p-2 border-0 box-border shadow-none"
          rows="1"
          placeholder=${placeholderText}
          .value=${this.value}
          @input=${this._onInput}
          @keydown=${this._onKeydown}
        ></textarea>
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
    if (!textarea) return

    // Function to attempt resize until the textarea is ready
    const tryResize = () => {
      if (textarea.offsetParent === null || textarea.scrollHeight === 0) {
        requestAnimationFrame(tryResize)
        return
      }

      textarea.style.height = '0px'
      requestAnimationFrame(() => {
        textarea.style.height = 'auto'
        textarea.style.height = textarea.scrollHeight + 'px'
      })
    }

    tryResize()
  }

  connectedCallback() {
    super.connectedCallback()

    // Watch for layout/visibility changes
    this._resizeObserver = new ResizeObserver(() => {
      const textarea = this.querySelector('textarea')
      if (textarea) this._resize(textarea)
    })

    this._resizeObserver.observe(this)

    // Also watch for class changes
    this._classObserver = new MutationObserver((mutations) => {
      for (const m of mutations) {
        if (m.attributeName === 'class') {
          this.requestUpdate()
        }
      }
    })

    this._classObserver.observe(this, { attributes: true })

    const form = this.closest('form')
    this.addEventListener('focusin', () => form?.classList.add('is-focused'))
    this.addEventListener('focusout', () =>
      form?.classList.remove('is-focused')
    )
  }

  disconnectedCallback() {
    this._classObserver?.disconnect()
    this._resizeObserver?.disconnect()
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
    const textarea = this.querySelector('textarea')
    if (textarea) {
      textarea.style.height = 'auto'
    }
  }

  formStateRestoreCallback(state) {
    this.value = state
  }
}

customElements.define('athens-textarea-litdev', AthensTextareaLitdev)
