import {
  LitElement,
  html
} from 'https://cdn.jsdelivr.net/gh/lit/dist@3/core/lit-core.min.js'

class AthensPreview extends LitElement {
  static formAssociated = true
  internals

  static properties = {
    value: { type: String, reflect: true },
    clampClass: { type: String }
  }

  constructor() {
    super()
    this.internals = this.attachInternals()
    this.value = ''
    this._isHidden = false
    this.clampClass = 'h-auto'
  }

  createRenderRoot() {
    return this
  }

  render() {
    return html`
      <div class="athens-editor flex items-start">
        <div
          class="markdown-preview ${this
            .clampClass} w-full prose prose-p:mb-0 prose-p:mt-0 inline-block translate-y-[-4px] align-top min-h-[16px]"
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

    if (this._isHidden) {
      const athensEditor = this.querySelector('.athens-editor')
      const truncateValue = this._smartTruncate(this.value, athensEditor)
      preview.innerHTML = window.marked.parse(truncateValue)
    } else {
      preview.innerHTML = window.marked.parse(trimValue)
    }

    // Remove empty trailing paragraph if it exists
    const last = preview.lastElementChild
    if (last?.tagName === 'P' && !last.textContent.trim()) {
      last.remove()
    }

    this._applyHideStyles(preview)
  }

  _applyHideStyles(preview) {
    if (this._isHidden) {
      this.clampClass = 'clamp-one-line h-[16px]'
      this.requestUpdate() // Trigger re-render
    } else {
      this.clampClass = 'h-auto'
      this.requestUpdate() // Trigger re-render
      requestAnimationFrame(() => {
        const initialHeight = preview.offsetHeight
        this.clampClass = `h-[${initialHeight - 4}px]`
        this.requestUpdate() // Trigger re-render after height calculation
      })
    }
  }

  _smartTruncate(text, athensEditorElement) {
    const maxLength = athensEditorElement
      ? Math.floor(athensEditorElement.offsetWidth / 8)
      : 85

    let cleanText = text
      .replace(/\.\.\.+$/, '') // Remove existing ellipsis
      .replace(/\s*-+\s*$/, '') // Remove trailing dashes with optional spaces
      .trim()

    if (cleanText.length <= maxLength) return cleanText

    let truncated = cleanText.substring(0, maxLength)

    let lastSpace = truncated.lastIndexOf(' ')

    if (lastSpace > 0) {
      truncated = cleanText.substring(0, lastSpace)
    }

    truncated = truncated.replace(/\s*-+\s*$/, '').trim()

    return truncated + '...'
  }

  _checkHideStateChange() {
    const shouldHide = this.classList.contains('hide')

    if (shouldHide !== this._isHidden) {
      this._isHidden = shouldHide
      this._updatePreview()
    }
  }

  connectedCallback() {
    super.connectedCallback()

    this._isHidden = this.classList.contains('hide')

    if (this._isHidden) {
      this.clampClass = 'clamp-one-line h-[16px]'
    } else {
      this.clampClass = 'h-auto'
    }

    this._classObserver = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        if (
          mutation.type === 'attributes' &&
          mutation.attributeName === 'class'
        ) {
          this._checkHideStateChange()
        }
      })
    })

    // Start observing class changes
    this._classObserver.observe(this, {
      attributes: true,
      attributeFilter: ['class'],
      attributeOldValue: true
    })

    this.updateComplete.then(() => {
      this._updatePreview()
    })
  }

  disconnectedCallback() {
    super.disconnectedCallback()
    if (this._classObserver) {
      this._classObserver.disconnect()
    }
  }
}

customElements.define('athens-preview', AthensPreview)
