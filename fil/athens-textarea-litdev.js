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
            .textareaClass} flex items-center min-h-[14px] h-[0px] max-h-[35vh] overflow-y-auto w-full focus:text-white focus:outline-none leading-[14px] text-[14px] md:text-[14px] py-[7px] px-2 border-0 box-border shadow-none"
          rows="1"
          placeholder=${placeholderText}
          .value=${this.value}
          @input=${this._onInput}
          @keydown=${this._onKeydown}
          required
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

  _onSubmit() {
    if (this.name !== 'edit-input') {
      this.value = ''
    } else {
      const currentValue = this.value

      requestAnimationFrame(() => {
        this.value = currentValue
        const textarea = this.querySelector('textarea')
        if (textarea) {
          textarea.value = currentValue
        }
      })
    }
  }

  _resize(textarea) {
    if (!textarea) return
    let gradient = document.getElementsByClassName('gradient-bottom')[0]

    // Function to attempt resize until the textarea is ready
    const tryResize = () => {
      if (textarea.offsetParent === null || textarea.scrollHeight === 0) {
        requestAnimationFrame(tryResize)
        return
      }

      textarea.style.height = '0px'
      gradient.style.height =
        this.name === 'edit-input' || this.name === 'reply-input'
          ? '120px'
          : '88px'
      requestAnimationFrame(() => {
        const isEditOrReply =
          this.name === 'edit-input' || this.name === 'reply-input'
        const defaultTextareaHeight = 28
        const defaultGradientHeight = isEditOrReply ? 140 : 88

        const finalTextareaHeight = Math.max(
          defaultTextareaHeight,
          textarea.scrollHeight
        )

        const additionalGradientHeight = isEditOrReply ? 100 : 60

        const finalGradientHeight =
          textarea.scrollHeight > defaultTextareaHeight
            ? finalTextareaHeight + additionalGradientHeight
            : defaultGradientHeight

        textarea.style.height = finalTextareaHeight + 'px'
        gradient.style.height = finalGradientHeight + 'px'
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
    form.addEventListener('submit', this._onSubmit.bind(this))
  }

  disconnectedCallback() {
    this._classObserver?.disconnect()
    this._resizeObserver?.disconnect()

    const form = this.closest('form')
    if (form) {
      form.removeEventListener('submit', this._onSubmit.bind(this))
    }
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
