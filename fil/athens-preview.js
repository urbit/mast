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
    if (this.classList.contains('hide')) {
      const truncateValue = smartTruncate(this.value)
      preview.innerHTML = window.marked.parse(truncateValue)
    } else {
      preview.innerHTML = window.marked.parse(trimValue)
    }

    // Remove empty trailing paragraph if it exists
    const last = preview.lastElementChild
    if (last?.tagName === 'P' && !last.textContent.trim()) {
      last.remove()
    }

    if (this.classList.contains('hide')) {
      preview.style.height = '16px'
      this.clampClass = 'clamp-one-line'
    } else {
      preview.style.height = 'auto'
      this.clampClass = ''
      requestAnimationFrame(() => {
        const initialHeight = preview.offsetHeight
        preview.style.height = `${initialHeight - 4}px`
      })
    }

    function smartTruncate(text) {
      const maxLength = 85
      let cleanText = text
        .replace(/\.\.\.+$/, '') // Remove existing ellipsis
        .replace(/\s*-+\s*$/, '') // Remove trailing dashes with optional spaces
        .trim()

      if (cleanText.length <= maxLength) return cleanText + '...'

      let truncated = cleanText.substring(0, maxLength)

      let lastSpace = truncated.lastIndexOf(' ')

      if (lastSpace > 0) {
        truncated = cleanText.substring(0, lastSpace)
      }

      truncated = truncated.replace(/\s*-+\s*$/, '').trim()

      return truncated + '...'
    }
  }

  connectedCallback() {
    super.connectedCallback()
  }

  disconnectedCallback() {}
}

customElements.define('athens-preview', AthensPreview)
