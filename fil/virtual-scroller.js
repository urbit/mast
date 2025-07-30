import {
  LitElement,
  html,
  css
} from 'https://cdn.jsdelivr.net/gh/lit/dist@3/core/lit-core.min.js'

class VirtualScroller extends LitElement {
  static styles = css`
    :host {
      height: 100vh;
      display: block;
      overflow-y: auto;
      position: relative;
    }

    ::slotted(.hidden) {
      display: none !important;
    }
  `

  constructor() {
    super()
    this.trackedElements = new Set()
    this.pendingTimeouts = new Map()
    this.observer = null
    this.keyboardHandler = this.handleKeyboard.bind(this)
  }

  connectedCallback() {
    super.connectedCallback()
    document.addEventListener('keydown', this.keyboardHandler)
  }

  disconnectedCallback() {
    super.disconnectedCallback()
    document.removeEventListener('keydown', this.keyboardHandler)
    if (this.observer) {
      this.observer.disconnect()
    }
    // Cancel all pending timeouts on disconnect
    this.pendingTimeouts.forEach((timeoutId) => clearTimeout(timeoutId))
    this.pendingTimeouts.clear()
  }

  firstUpdated() {
    this.setupIntersectionObserver()
    this.addEventListener('scroll', this.handleScroll.bind(this))
  }

  setupIntersectionObserver() {
    const options = {
      root: this,
      rootMargin: '0px 0px -100% 0px', // Only trigger when element is above viewport
      threshold: 0
    }

    this.observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        // When element exits the viewport from the top
        if (
          !entry.isIntersecting &&
          entry.boundingClientRect.bottom < entry.rootBounds.top
        ) {
          this.handleElementAboveViewport(entry.target)
        }
        // When element comes back into view, cancel any pending timeout
        else if (
          entry.isIntersecting &&
          this.pendingTimeouts.has(entry.target)
        ) {
          clearTimeout(this.pendingTimeouts.get(entry.target))
          this.pendingTimeouts.delete(entry.target)
          this.trackedElements.delete(entry.target)
          this.logEvent(
            `Cancelled timer for element: ${
              entry.target.id || 'hidden element'
            } (back in view)`
          )
        }
      })
    }, options)

    // Observe all slotted elements with IDs or without IDs (which should have hidden class)
    this.observeSlottedElements()
  }

  observeSlottedElements() {
    const slot = this.shadowRoot.querySelector('slot')
    const slottedElements = slot.assignedElements()
    console.log('slottedElements', slottedElements)

    slottedElements.forEach((element) => {
      // Only observe elements with IDs or elements without IDs that have hidden class
      if (element.id || (!element.id && element.classList.contains('hidden'))) {
        this.observer.observe(element)
      }
    })
  }

  handleElementAboveViewport(element) {
    // Prevent multiple triggers for the same element
    if (this.trackedElements.has(element)) {
      return
    }

    this.trackedElements.add(element)

    // Find and trigger the track-visibility element
    const trackElement = element.querySelector('.track-visibility')
    if (trackElement) {
      console.log('setting timer for', element)
      const timeoutId = setTimeout(() => {
        trackElement.dispatchEvent(new Event('submit', { bubbles: true }))

        // Log for demo purposes
        this.logEvent(
          `Triggered submit event for element: ${
            element.id || 'hidden element'
          }`
        )

        // Clean up
        this.pendingTimeouts.delete(element)
      }, 3000) // 3 seconds delay

      // Store the timeout ID so we can cancel it if needed
      this.pendingTimeouts.set(element, timeoutId)
    }
  }

  handleKeyboard(e) {
    // Only handle keys when this scroller is focused or visible
    if (!this.isConnected) return

    const tag = document.activeElement?.tagName?.toLowerCase()
    if (
      ['input', 'textarea'].includes(tag) ||
      document.activeElement?.isContentEditable
    ) {
      return
    }

    if (e.key === 'j' || e.key === ' ' || e.key === 'ArrowDown') {
      console.log('down keyboard event')
      e.preventDefault()
      scrollToNearest('below')
    } else if (e.key === 'k' || e.key === 'ArrowUp') {
      console.log('up keyboard event')
      e.preventDefault()
      scrollToNearest('above')
    }
  }

  handleScroll() {
    // Reset tracking when scrolling back up significantly
    const scrollTop = this.scrollTop
    if (scrollTop < 100) {
      console.log('canceling timers')
      // Cancel all pending timeouts
      this.pendingTimeouts.forEach((timeoutId) => clearTimeout(timeoutId))
      this.pendingTimeouts.clear()
      this.trackedElements.clear()
    }
  }

  logEvent(message) {
    const eventLog = document.getElementById('event-log')
    if (eventLog) {
      const timestamp = new Date().toLocaleTimeString()
      eventLog.innerHTML += `<div>[${timestamp}] ${message}</div>`
      eventLog.scrollTop = eventLog.scrollHeight
    }
  }

  render() {
    return html`<slot @slotchange=${this.handleSlotChange}></slot>`
  }

  handleSlotChange() {
    // Re-observe elements when slot content changes
    if (this.observer) {
      this.observer.disconnect()
      // Cancel all pending timeouts when slot changes
      this.pendingTimeouts.forEach((timeoutId) => clearTimeout(timeoutId))
      this.pendingTimeouts.clear()
      this.trackedElements.clear()
      this.observeSlottedElements()
    }
  }
}

customElements.define('virtual-scroller', VirtualScroller)
