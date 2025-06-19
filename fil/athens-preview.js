import {
  LitElement,
  html
} from 'https://cdn.jsdelivr.net/gh/lit/dist@3/core/lit-core.min.js'

class AthensPreview extends LitElement {
  static formAssociated = true
  internals

  static properties = {
    value: { type: String, reflect: true },
    activeTab: { type: String },
    textareaClass: { type: String },
    clampClass: { type: String }
  }

  constructor() {
    super()
    this.internals = this.attachInternals()
    this.value = ''
    this.clampClass = this.classList.contains('hide') ? 'clamp-one-line' : ''
  }

  createRenderRoot() {
    return this
  }

  render() {
    return html`
      <div class="athens-editor flex items-start">
        <div
          class="markdown-preview ${this
            .clampClass} prose prose-p:mb-0 prose-p:mt-0 inline-block translate-y-[-4px] align-top min-h-[16px]"
          id="preview"
        ></div>
      </div>
    `
  }

  updated(changed) {
    if (changed.has('value')) {
      this._updatePreview()
    }
  }

  _updatePreview() {
    const preview = this.querySelector('#preview')
    if (!preview || !window.marked) return

    const renderer = new window.marked.Renderer()

    renderer.image = () => ''

    renderer.html = (html) => {
      if (/<audio[\s\S]*?>[\s\S]*?<\/audio>/gi.test(html)) {
        return ''
      }
      return html
    }

    window.marked.setOptions({
      breaks: true,
      renderer
    })

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

    // Attach observer
    this._classObserver = new MutationObserver(() => {
      this._syncClampClass()
    })

    this._classObserver.observe(this, {
      attributes: true,
      attributeFilter: ['class']
    })

    // Initialize clampClass immediately (in case class was already set)
    this._syncClampClass()
  }

  disconnectedCallback() {
    this._classObserver?.disconnect()
  }

  _syncClampClass() {
    const newClamp = this.classList.contains('hide') ? 'clamp-one-line' : ''
    this.clampClass = newClamp
    this.requestUpdate('clampClass')
    this._updatePreview()
  }
}

customElements.define('athens-preview', AthensPreview)
