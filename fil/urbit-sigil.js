import { sigil, stringRenderer } from 'https://cdn.skypack.dev/urbit-sigil-js'

class SigilElement extends HTMLElement {
  static get observedAttributes() {
    return ['patp']
  }

  constructor() {
    super()
    this.isHovered = false
    this.isClicked = false
    this.menuElements = []
    this.boundHandlers = {
      mouseenter: null,
      mouseleave: null,
      onClick: null
    }
  }

  connectedCallback() {
    this.render()
    this.setupHoverEvents()
  }

  disconnectedCallback() {
    this.removeHoverEvents()
  }

  setupHoverEvents() {
    this.menuElements = document.querySelectorAll('.menu')

    if (this.menuElements.length === 0) {
      return
    }

    this.boundHandlers.mouseenter = () => {
      this.isHovered = true
      requestAnimationFrame(() => {
        this.render()
      })
    }

    this.boundHandlers.mouseleave = () => {
      this.isHovered = false
      requestAnimationFrame(() => {
        this.render()
      })
    }

    this.boundHandlers.onClick = () => {
      this.isClicked = !this.isClicked
      this.isHovered = this.isClicked
      console.log('isClicked:', this.isClicked)
      console.log('isHovered:', this.isHovered)
      requestAnimationFrame(() => {
        this.render()
      })
    }

    this.menuElements.forEach((element) => {
      element.addEventListener('mouseenter', this.boundHandlers.mouseenter)
      element.addEventListener('mouseleave', this.boundHandlers.mouseleave)
      element.addEventListener('click', this.boundHandlers.onClick)
    })
  }

  removeHoverEvents() {
    if (
      this.menuElements.length > 0 &&
      this.boundHandlers.mouseenter &&
      this.boundHandlers.mouseleave
    ) {
      this.menuElements.forEach((element) => {
        element.removeEventListener('mouseenter', this.boundHandlers.mouseenter)
        element.removeEventListener('mouseleave', this.boundHandlers.mouseleave)
      })
    }
  }

  attributeChangedCallback() {
    this.render()
  }

  render() {
    const patp = this.getAttribute('patp')
    if (!patp) return
    const color = this.isHovered || this.isClicked ? '#A3A3A3' : '#737373'

    const svgString = sigil({
      patp: patp.slice(1),
      renderer: stringRenderer,
      size: 14,
      margin: false,
      colors: ['none', color]
    })

    this.innerHTML = svgString
    this.style.width = '14px'
  }
}

customElements.define('urbit-sigil', SigilElement)
