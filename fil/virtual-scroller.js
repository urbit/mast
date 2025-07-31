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
    this.currentTargetIndex = -1

    // Touch handling properties
    this.touchStartY = 0
    this.touchStartTime = 0
    this.touchThreshold = 50 // minimum distance for swipe
    this.touchTimeThreshold = 300 // maximum time for quick swipe (ms)
    this.isScrolling = false
  }

  connectedCallback() {
    super.connectedCallback()
    document.addEventListener('keydown', this.keyboardHandler)

    // Add touch event listeners
    this.addEventListener('touchstart', this.handleTouchStart.bind(this), {
      passive: false
    })
    this.addEventListener('touchmove', this.handleTouchMove.bind(this), {
      passive: false
    })
    this.addEventListener('touchend', this.handleTouchEnd.bind(this), {
      passive: false
    })
  }

  disconnectedCallback() {
    super.disconnectedCallback()
    document.removeEventListener('keydown', this.keyboardHandler)

    // Remove touch event listeners
    this.removeEventListener('touchstart', this.handleTouchStart)
    this.removeEventListener('touchmove', this.handleTouchMove)
    this.removeEventListener('touchend', this.handleTouchEnd)

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

    const trackElement = element.querySelector('.track-visibility')
    if (trackElement) {
      const timeoutId = setTimeout(() => {
        trackElement.dispatchEvent(new Event('submit', { bubbles: true }))

        this.pendingTimeouts.delete(element)
      }, 3000)

      this.pendingTimeouts.set(element, timeoutId)
    }
  }

  getAllPosts() {
    return Array.from(document.querySelectorAll('.post-container'))
  }

  getCurrentTargetIndex() {
    const allPosts = this.getAllPosts()
    const currentTarget = document.querySelector('.post-container.target')
    if (currentTarget) {
      return allPosts.indexOf(currentTarget)
    }
    return -1
  }

  setTargetClass(element) {
    // Remove target class from all posts
    const allPosts = this.getAllPosts()
    allPosts.forEach((post) => post.classList.remove('target'))

    if (element) {
      element.classList.add('target')
    }
  }

  scrollToNearest(direction) {
    const allPosts = this.getAllPosts()
    if (allPosts.length === 0) return

    let targetIndex
    const currentIndex = this.getCurrentTargetIndex()
    const currentTarget = currentIndex !== -1 ? allPosts[currentIndex] : null

    // Check if current target is still visible in viewport
    const isCurrentTargetVisible = currentTarget
      ? this.isElementVisible(currentTarget)
      : false

    if (direction === 'below') {
      if (currentIndex === -1 || !isCurrentTargetVisible) {
        const topVisibleIndex = this.findPostAtTopOfViewport(allPosts)
        if (topVisibleIndex !== -1) {
          targetIndex =
            direction === 'below'
              ? Math.min(topVisibleIndex + 1, allPosts.length - 1)
              : topVisibleIndex
        } else {
          targetIndex = 0
        }
      } else {
        targetIndex = Math.min(currentIndex + 1, allPosts.length - 1)
      }
    } else if (direction === 'above') {
      if (currentIndex === -1 || !isCurrentTargetVisible) {
        const topVisibleIndex = this.findPostAtTopOfViewport(allPosts)
        if (topVisibleIndex !== -1) {
          targetIndex = Math.max(topVisibleIndex - 1, 0)
        } else {
          targetIndex = 0
        }
      } else {
        targetIndex = Math.max(currentIndex - 1, 0)
      }
    }

    if (targetIndex !== undefined && allPosts[targetIndex]) {
      this.setTargetClass(allPosts[targetIndex])
      this.scrollToTop(allPosts[targetIndex])
      this.currentTargetIndex = targetIndex
    }
  }

  isElementVisible(element) {
    const scrollerRect = this.getBoundingClientRect()
    const elementRect = element.getBoundingClientRect()

    const visibleTop = scrollerRect.top + 70
    const visibleBottom = scrollerRect.bottom

    return elementRect.bottom > visibleTop && elementRect.top < visibleBottom
  }

  findPostAtTopOfViewport(allPosts) {
    const scrollerRect = this.getBoundingClientRect()
    const visibleTop = scrollerRect.top + 70

    for (let i = 0; i < allPosts.length; i++) {
      const postRect = allPosts[i].getBoundingClientRect()

      if (postRect.bottom > visibleTop) {
        return i
      }
    }

    return -1
  }

  handleTouchStart(e) {
    this.touchStartY = e.touches[0].clientY
    this.touchStartTime = Date.now()
    this.isScrolling = false
  }

  handleTouchMove(e) {
    // Allow normal scrolling, just track that we're scrolling
    this.isScrolling = true
  }

  handleTouchEnd(e) {
    if (this.isScrolling) return

    const touchEndY = e.changedTouches[0].clientY
    const touchEndTime = Date.now()

    const deltaY = this.touchStartY - touchEndY
    const deltaTime = touchEndTime - this.touchStartTime

    // Check if it's a quick swipe
    if (
      deltaTime <= this.touchTimeThreshold &&
      Math.abs(deltaY) >= this.touchThreshold
    ) {
      e.preventDefault()

      if (deltaY > 0) {
        this.scrollByViewport('down')
      } else {
        this.scrollByViewport('up')
      }
    }
  }

  scrollByViewport(direction) {
    const viewportHeight = this.clientHeight - 70
    const currentScrollTop = this.scrollTop

    let targetScrollTop
    if (direction === 'down') {
      targetScrollTop = currentScrollTop + viewportHeight
    } else {
      targetScrollTop = Math.max(0, currentScrollTop - viewportHeight)
    }

    this.scrollTo({
      top: targetScrollTop,
      behavior: 'smooth'
    })
  }

  scrollToTop(element) {
    if (!element) return

    const scrollerRect = this.getBoundingClientRect()
    const elementRect = element.getBoundingClientRect()

    const scrollOffset =
      elementRect.top - scrollerRect.top + this.scrollTop - 70

    // Smooth scroll to position
    this.scrollTo({
      top: scrollOffset,
      behavior: 'smooth'
    })
  }

  handleKeyboard(e) {
    if (!this.isConnected) return

    const tag = document.activeElement?.tagName?.toLowerCase()
    if (
      ['input', 'textarea'].includes(tag) ||
      document.activeElement?.isContentEditable
    ) {
      return
    }

    if (e.key === 'j' || e.key === ' ' || e.key === 'ArrowDown') {
      e.preventDefault()
      this.scrollToNearest('below')
    } else if (e.key === 'k' || e.key === 'ArrowUp') {
      e.preventDefault()
      this.scrollToNearest('above')
    }
  }

  handleScroll() {
    // Reset tracking when scrolling back up significantly
    const scrollTop = this.scrollTop
    if (scrollTop < 100) {
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
