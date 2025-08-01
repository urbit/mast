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

      /* Hide scrollbar */
      -ms-overflow-style: none; /* Internet Explorer 10+ */
      scrollbar-width: none; /* Firefox */
    }

    :host::-webkit-scrollbar {
      display: none; /* Safari and Chrome */
    }

    ::slotted(.hidden) {
      display: none !important;
    }

    /* Position indicator styles */
    .position-indicator {
      position: fixed;
      z-index: 100;
    }

    .tracker-button {
      background: rgb(3 7 18);
      border: 1px solid var(--grey-default);
      border-radius: 0.375rem;
      padding: 8px;
      font-family: Inter, sans-serif;
      color: var(--grey-default);
      display: none;
      align-items: center;
      gap: 0.25rem;
      cursor: pointer;
      transition: all 0.2s ease;
      height: 28px;
      box-sizing: border-box;
      font-size: 14px;
    }

    .tracker-button:hover {
      border-color: var(--grey-light);
      color: var(--grey-light);
    }

    .tracker-button.visible {
      display: flex;
    }

    .desktop-trackers {
      display: block;
    }

    .mobile-trackers {
      display: none;
      top: 24px;
      left: 24px;
      gap: 0.5rem;
    }

    @media (max-width: 768px) {
      .desktop-trackers {
        display: none;
      }

      .mobile-trackers {
        display: flex;
      }
    }

    #tracker-above {
      top: 24px;
      left: 24px;
    }

    #tracker-below {
      bottom: 24px;
      left: 24px;
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
    this.touchThreshold = 50
    this.touchTimeThreshold = 300
    this.isScrolling = false

    // Notification tracking properties
    this.notificationElements = []
    this.updateElementsInterval = null
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

    this.initializeNotificationTracking()
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

    // Clear notification tracking interval
    if (this.updateElementsInterval) {
      clearInterval(this.updateElementsInterval)
    }
  }

  firstUpdated() {
    this.setupIntersectionObserver()
    this.addEventListener('scroll', this.handleScroll.bind(this))
  }

  initializeNotificationTracking() {
    this.updateNotificationElements()
    this.updateNotificationPositions()

    // Update elements periodically
    this.updateElementsInterval = setInterval(() => {
      this.updateNotificationElements()
      this.updateNotificationPositions()
    }, 1000)
  }

  updateNotificationElements() {
    const spans = document.querySelectorAll('span.new')

    this.notificationElements = Array.from(spans).map((span) => {
      const text = span.textContent.trim()
      const cleanedText = text.startsWith('+') ? text.slice(1) : text
      const value = parseInt(cleanedText) || 0
      return {
        element: span,
        value: value
      }
    })
  }

  updateNotificationPositions() {
    const scrollerRect = this.getBoundingClientRect()
    const viewportTop = this.scrollTop + 60
    const viewportBottom = viewportTop + this.clientHeight - 110

    let aboveSum = 0
    let belowSum = 0

    this.notificationElements.forEach(({ element, value }) => {
      const elementRect = element.getBoundingClientRect()
      const scrollerTopOffset = scrollerRect.top
      const elementTop = elementRect.top - scrollerTopOffset + this.scrollTop
      const elementBottom = elementTop + elementRect.height

      if (elementBottom < viewportTop) {
        aboveSum += value
      } else if (elementTop > viewportBottom) {
        belowSum += value
      }
    })

    this.updateNotificationDisplay(aboveSum, belowSum)
  }

  updateNotificationDisplay(aboveSum, belowSum) {
    this.requestUpdate()

    // Update the rendered indicators after the next render
    this.updateComplete.then(() => {
      const trackerAbove = this.shadowRoot.querySelector('#tracker-above')
      const trackerBelow = this.shadowRoot.querySelector('#tracker-below')
      const mobileAbove = this.shadowRoot.querySelector('#mobile-tracker-above')
      const mobileBelow = this.shadowRoot.querySelector('#mobile-tracker-below')

      // Update desktop indicators
      if (trackerAbove) {
        const aboveNumber = trackerAbove.querySelector('.above-number')
        if (aboveSum > 0) {
          trackerAbove.classList.add('visible')
          if (aboveNumber) aboveNumber.textContent = aboveSum
        } else {
          trackerAbove.classList.remove('visible')
        }
      }

      if (trackerBelow) {
        const belowNumber = trackerBelow.querySelector('.below-number')
        if (belowSum > 0) {
          trackerBelow.classList.add('visible')
          if (belowNumber) belowNumber.textContent = belowSum
        } else {
          trackerBelow.classList.remove('visible')
        }
      }

      // Update mobile indicators
      if (mobileAbove) {
        const aboveNumber = mobileAbove.querySelector('.above-number')
        if (aboveSum > 0) {
          mobileAbove.classList.add('visible')
          if (aboveNumber) aboveNumber.textContent = aboveSum
        } else {
          mobileAbove.classList.remove('visible')
        }
      }

      if (mobileBelow) {
        const belowNumber = mobileBelow.querySelector('.below-number')
        if (belowSum > 0) {
          mobileBelow.classList.add('visible')
          if (belowNumber) belowNumber.textContent = belowSum
        } else {
          mobileBelow.classList.remove('visible')
        }
      }
    })
  }

  scrollToNearestNotification(direction) {
    const scrollerRect = this.getBoundingClientRect()
    const viewportTop = this.scrollTop + 60
    const viewportBottom = viewportTop + this.clientHeight - 110

    let targetPost = null
    let bestDistance = Infinity

    // Look through all .new elements to find ones in the requested direction
    const newElements = document.querySelectorAll('span.new')

    newElements.forEach((newElement) => {
      const text = newElement.textContent.trim()
      const cleanedText = text.startsWith('+') ? text.slice(1) : text
      const value = parseInt(cleanedText) || 0

      if (value <= 0) return // Skip if no new items

      const elementRect = newElement.getBoundingClientRect()
      const scrollerTopOffset = scrollerRect.top
      const elementTop = elementRect.top - scrollerTopOffset + this.scrollTop
      const elementBottom = elementTop + elementRect.height

      let shouldConsider = false
      let distance = 0

      if (direction === 'above' && elementBottom < viewportTop) {
        shouldConsider = true
        distance = viewportTop - elementBottom
      } else if (direction === 'below' && elementTop > viewportBottom) {
        shouldConsider = true
        distance = elementTop - viewportBottom
      }

      if (shouldConsider && distance < bestDistance) {
        // Find the .post-container that contains this .new element
        const postContainer = newElement.closest('.post-container')
        if (postContainer) {
          bestDistance = distance
          targetPost = postContainer
        }
      }
    })

    if (targetPost) {
      // Set target class and scroll to the post
      this.setTargetClass(targetPost)
      this.scrollToTop(targetPost)

      // Update current target index
      const allPosts = this.getAllPosts()
      this.currentTargetIndex = allPosts.indexOf(targetPost)
    } else {
      // Fallback: use regular post navigation if no notification post found
      this.scrollToNearest(direction)
    }
  }

  setupIntersectionObserver() {
    const options = {
      root: this,
      rootMargin: '0px 0px -100% 0px',
      threshold: 0
    }

    this.observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (
          !entry.isIntersecting &&
          entry.boundingClientRect.bottom < entry.rootBounds.top
        ) {
          this.handleElementAboveViewport(entry.target)
        } else if (
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

    this.observeSlottedElements()
  }

  observeSlottedElements() {
    const slot = this.shadowRoot.querySelector('slot')
    const slottedElements = slot.assignedElements()

    slottedElements.forEach((element) => {
      if (element.id || (!element.id && element.classList.contains('hidden'))) {
        this.observer.observe(element)
      }
    })
  }

  handleElementAboveViewport(element) {
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
    this.isScrolling = true
  }

  handleTouchEnd(e) {
    if (this.isScrolling) return

    const touchEndY = e.changedTouches[0].clientY
    const touchEndTime = Date.now()

    const deltaY = this.touchStartY - touchEndY
    const deltaTime = touchEndTime - this.touchStartTime

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
    const scrollTop = this.scrollTop
    if (scrollTop < 100) {
      this.pendingTimeouts.forEach((timeoutId) => clearTimeout(timeoutId))
      this.pendingTimeouts.clear()
      this.trackedElements.clear()
    }

    // Update notification positions on scroll
    this.updateNotificationPositions()
  }

  logEvent(message) {
    const eventLog = document.getElementById('event-log')
    if (eventLog) {
      const timestamp = new Date().toLocaleTimeString()
      eventLog.innerHTML += `<div>[${timestamp}] ${message}</div>`
      eventLog.scrollTop = eventLog.scrollHeight
    }
  }

  handleNotificationClick(direction) {
    console.log('handle notification click', direction)
    if (direction === 'above') {
      const event = new CustomEvent('click/toggle-hide')
      document.dispatchEvent(event)
    }
    this.scrollToNearestNotification(direction)
  }

  render() {
    return html`
      <slot @slotchange=${this.handleSlotChange}></slot>

      <!-- Desktop notification indicators -->
      <div class="desktop-trackers">
        <div
          id="tracker-above"
          class="tracker-button position-indicator"
          @click=${() => this.handleNotificationClick('above')}
        >
          <span>↑</span>
          <span class="above-number">0</span>
          <span>new</span>
        </div>
        <div
          id="tracker-below"
          class="tracker-button position-indicator"
          @click=${() => this.handleNotificationClick('below')}
        >
          <span>↓</span>
          <span class="below-number">0</span>
          <span>new</span>
        </div>
      </div>

      <!-- Mobile notification indicators -->
      <div class="mobile-trackers position-indicator">
        <div
          id="mobile-tracker-above"
          class="tracker-button"
          @click=${() => this.handleNotificationClick('above')}
        >
          <span>↑</span>
          <span class="above-number">0</span>
          <span>new</span>
        </div>
        <div
          id="mobile-tracker-below"
          class="tracker-button"
          @click=${() => this.handleNotificationClick('below')}
        >
          <span>↓</span>
          <span class="below-number">0</span>
          <span>new</span>
        </div>
      </div>
    `
  }

  handleSlotChange() {
    if (this.observer) {
      this.observer.disconnect()
      this.pendingTimeouts.forEach((timeoutId) => clearTimeout(timeoutId))
      this.pendingTimeouts.clear()
      this.trackedElements.clear()
      this.observeSlottedElements()
    }
  }
}

customElements.define('virtual-scroller', VirtualScroller)

// Focus tracking functionality
document.addEventListener('DOMContentLoaded', () => {
  function setupFocusTracking() {
    const inputs = document.querySelectorAll(
      'input.track-focus, textarea.track-focus'
    )

    inputs.forEach((input) => {
      input.addEventListener('focus', () => {
        const postForm = document.getElementById('post-form')
        if (postForm) {
          postForm.classList.add('hidden')
        }
      })

      input.addEventListener('blur', () => {
        const postForm = document.getElementById('post-form')
        if (postForm) {
          postForm.classList.remove('hidden')
        }
      })
    })
  }

  const focusMutationObserver = new MutationObserver(() => {
    setupFocusTracking()
  })

  focusMutationObserver.observe(document.body, {
    childList: true,
    subtree: true
  })

  // Initialize focus tracking
  setupFocusTracking()
})
