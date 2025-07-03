document.addEventListener('DOMContentLoaded', () => {
  const trackedElements = new Set()
  const lastStates = new Map()

  function getTrackedElements() {
    return Array.from(document.querySelectorAll('.track-visibility'))
  }

  const grandparentToChildMap = new Map()

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        const grandparent = entry.target
        const child = grandparentToChildMap.get(grandparent)
        if (!child) return

        const isOutOfView =
          entry.boundingClientRect.top < 0 && !entry.isIntersecting
        const wasOutOfView = lastStates.get(child) || false

        if (!wasOutOfView && isOutOfView && document.body.contains(child)) {
          triggerEvent(child)
        }

        lastStates.set(child, isOutOfView)
      })
    },
    { threshold: 0 }
  )

  function observeNewElements() {
    const elements = getTrackedElements()

    elements.forEach((child) => {
      const grandparent = child.parentElement?.parentElement
      if (!grandparent) return

      if (!trackedElements.has(grandparent)) {
        observer.observe(grandparent)
        trackedElements.add(grandparent)
        grandparentToChildMap.set(grandparent, child)
        lastStates.set(child, false)
      }
    })

    // Cleanup for removed elements
    trackedElements.forEach((grandparent) => {
      if (!document.body.contains(grandparent)) {
        observer.unobserve(grandparent)
        trackedElements.delete(grandparent)
        const child = grandparentToChildMap.get(grandparent)
        if (child) lastStates.delete(child)
        grandparentToChildMap.delete(grandparent)
      }
    })
  }

  function triggerEvent(elem) {
    try {
      const submitEvent = new Event('submit', {
        bubbles: true,
        cancelable: true
      })
      elem.dispatchEvent(submitEvent)
    } catch (err) {
      console.warn('Submit event failed:', err)
    }
  }

  const mutationObserver = new MutationObserver(() => {
    observeNewElements()

    if (window.positionTracker) {
      window.positionTracker.updateElements()
    }
  })

  mutationObserver.observe(document.body, {
    childList: true,
    subtree: true
  })

  observeNewElements()

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

  function getElementClosestToViewportCenter() {
    const elements = Array.from(getTrackedElements())
    const viewportCenter = window.innerHeight / 2

    let closestIndex = -1
    let smallestDistance = Infinity

    elements.forEach((el, index) => {
      const rect = el.getBoundingClientRect()
      const elementCenter = rect.top + rect.height / 2
      const distance = Math.abs(viewportCenter - elementCenter)

      if (distance < smallestDistance) {
        smallestDistance = distance
        closestIndex = index
      }
    })

    return closestIndex
  }

  let currentIndex = getElementClosestToViewportCenter()

  function scrollToIndex(index) {
    const elements = Array.from(document.querySelectorAll('.post-container'))

    const rect = elements[index].getBoundingClientRect()
    const scrollTop = window.pageYOffset || document.documentElement.scrollTop
    const targetY = scrollTop + rect.top - 50

    window.scrollTo({
      top: targetY,
      behavior: 'smooth'
    })

    currentIndex = index
  }

  document.addEventListener('keydown', (e) => {
    const tag = document.activeElement?.tagName?.toLowerCase()
    if (
      ['input', 'textarea'].includes(tag) ||
      document.activeElement?.isContentEditable
    ) {
      return
    }

    const elements = Array.from(document.querySelectorAll('.post-container'))
    if (!elements.length) return

    if (e.key === 'j' || e.key === ' ') {
      if (currentIndex < elements.length - 1) {
        scrollToIndex(currentIndex + 1)
      }
    } else if (e.key === 'k') {
      if (currentIndex > 0) {
        scrollToIndex(currentIndex - 1)
      }
    }
  })

  //  Handles scroll to the top for new replies and reply form

  window.scrollToElementTop = function (id, getParent) {
    const el = document.getElementById(id)

    const elem = getParent ? el?.parentElement?.parentElement : el

    if (!elem) return

    const rect = elem.getBoundingClientRect()
    const scrollTop = window.pageYOffset || document.documentElement.scrollTop
    const targetY = scrollTop + rect.top - 80
    window.scrollTo({
      top: targetY,
      behavior: 'smooth'
    })

    const elements = Array.from(
      Array.from(document.querySelectorAll('.post-container'))
    )
    const index = elements.indexOf(elem.querySelector('.post-container'))
    if (index !== -1) currentIndex = index
  }

  window.delayedScrollToTop = function (
    id,
    getParent = true,
    timeout = 5000,
    interval = 100
  ) {
    const startTime = Date.now()

    const check = () => {
      const el = document.getElementById(id)

      if (el && getParent && el.parentElement?.parentElement) {
        window.scrollToElementTop(id, getParent)
      } else if (el && !getParent) {
        window.scrollToElementTop(id, getParent)
      } else if (Date.now() - startTime < timeout) {
        setTimeout(check, interval) // check again
      } else {
        console.warn(`Element with id "${id}" not found within timeout.`)
      }
    }

    check()
  }

  //  Handles removing main form on reply or edit input focus

  // Track focus on inputs with .track-focus
  function setupGlobalFocusTracking() {
    const postForm = document.getElementById('post-form')
    if (!postForm) return

    let isInputFocused = false

    document.addEventListener('focusin', (e) => {
      if (e.target.matches('textarea.track-focus')) {
        isInputFocused = true
        postForm.classList.add('hidden')
      }
    })

    document.addEventListener('focusout', (e) => {
      setTimeout(() => {
        const focused = document.activeElement
        if (!focused || !focused.matches('textarea.track-focus')) {
          isInputFocused = false
          postForm.classList.remove('hidden')
        }
      }, 0)
    })
  }

  setupGlobalFocusTracking()

  const focusMutationObserver = new MutationObserver(() => {
    setupFocusTracking()
  })

  focusMutationObserver.observe(document.body, {
    childList: true,
    subtree: true
  })
  class PositionTracker {
    constructor() {
      this.elements = []
      this.createIndicator()
      this.init()
    }

    createIndicator() {
      // Create the fixed indicator if it doesn't exist
      if (!document.getElementById('position-indicator')) {
        const indicator = document.createElement('div')
        indicator.id = 'position-indicator'
        const buttonClass =
          'bg-gray-950 border border-[#A3A3A3] rounded p-2 font-inter text-sm text-[#A3A3A3] hidden items-center gap-1 cursor-pointer z-50 h-[32px]'

        indicator.innerHTML = `
          <!-- Desktop buttons -->
          <div id="desktop-tracker-container" class="hidden">
            <div id="tracker-above" class="tracker fixed top-[24px] left-[24px] ${buttonClass}">
              <span>↑</span>
              <span id="above-number">0</span>
              <span>new</span>
            </div>
            <div id="tracker-below" class="tracker fixed bottom-[24px] left-[24px] ${buttonClass}">
              <span>↓</span>
              <span id="below-number">0</span>
              <span>new</span>
            </div>
          </div>
          
          <!-- Mobile buttons container -->
          <div id="mobile-tracker-container" class="fixed top-[24px] left-[24px] hidden flex gap-2 z-50">
            <div id="mobile-tracker-above" class="tracker ${buttonClass}">
              <span>↑</span>
              <span id="mobile-above-number">0</span>
              <span>new</span>
            </div>
            <div id="mobile-tracker-below" class="tracker ${buttonClass}">
              <span>↓</span>
              <span id="mobile-below-number">0</span>
              <span>new</span>
            </div>
          </div>
        `
        document.body.appendChild(indicator)

        // Add click event listeners for desktop buttons
        const trackerAbove = document.getElementById('tracker-above')
        const trackerBelow = document.getElementById('tracker-below')

        // Add click event listeners for mobile buttons
        const mobileAbove = document.getElementById('mobile-tracker-above')
        const mobileBelow = document.getElementById('mobile-tracker-below')

        trackerAbove?.addEventListener('click', () =>
          this.scrollToNearest('above')
        )
        trackerBelow?.addEventListener('click', () =>
          this.scrollToNearest('below')
        )
        mobileAbove?.addEventListener('click', () =>
          this.scrollToNearest('above')
        )
        mobileBelow?.addEventListener('click', () =>
          this.scrollToNearest('below')
        )
      } else {
      }
    }

    init() {
      this.updateElements()
      this.updatePositions()

      // Use existing scroll event or add new one
      window.addEventListener('scroll', () => this.updatePositions())
      window.addEventListener('resize', () => this.updatePositions())

      // Update elements periodically
      setInterval(() => this.updateElements(), 1000)
    }

    updateElements() {
      const spans = document.querySelectorAll('span.new')

      this.elements = Array.from(spans).map((span) => {
        // Remove the "+" prefix and parse the number
        const text = span.textContent.trim()
        const cleanedText = text.startsWith('+') ? text.slice(1) : text
        const value = parseInt(cleanedText) || 0
        return {
          element: span,
          value: value
        }
      })
    }

    updatePositions() {
      const viewportTop = window.scrollY
      const viewportBottom = viewportTop + window.innerHeight

      let aboveSum = 0
      let belowSum = 0

      this.elements.forEach(({ element, value }) => {
        const rect = element.getBoundingClientRect()
        const elementTop = rect.top + window.scrollY
        const elementBottom = elementTop + rect.height

        // Check if element is above or below viewport
        if (elementBottom < viewportTop) {
          // Element is above viewport
          aboveSum += value
        } else if (elementTop > viewportBottom) {
          // Element is below viewport
          belowSum += value
        } else {
        }
      })

      // Update display
      this.updateDisplay(aboveSum, belowSum)
    }

    updateDisplay(aboveSum, belowSum) {
      const isMobile = window.innerWidth <= 768

      // Get all elements
      const desktopContainer = document.getElementById(
        'desktop-tracker-container'
      )
      const mobileContainer = document.getElementById(
        'mobile-tracker-container'
      )

      const trackerAbove = document.getElementById('tracker-above')
      const trackerBelow = document.getElementById('tracker-below')
      const aboveNumber = document.getElementById('above-number')
      const belowNumber = document.getElementById('below-number')

      const mobileAbove = document.getElementById('mobile-tracker-above')
      const mobileBelow = document.getElementById('mobile-tracker-below')
      const mobileAboveNumber = document.getElementById('mobile-above-number')
      const mobileBelowNumber = document.getElementById('mobile-below-number')

      if (isMobile) {
        // Hide desktop, show mobile
        if (desktopContainer) {
          desktopContainer.classList.add('hidden')
        }
        if (mobileContainer) {
          mobileContainer.classList.remove('hidden')
          mobileContainer.classList.add('flex')
        }

        // Update mobile buttons independently
        if (mobileAbove && mobileAboveNumber) {
          if (aboveSum > 0) {
            mobileAbove.classList.remove('hidden')
            mobileAbove.classList.add('flex')
            mobileAboveNumber.textContent = aboveSum
          } else {
            mobileAbove.classList.add('hidden')
            mobileAbove.classList.remove('flex')
          }
        }

        if (mobileBelow && mobileBelowNumber) {
          if (belowSum > 0) {
            mobileBelow.classList.remove('hidden')
            mobileBelow.classList.add('flex')
            mobileBelowNumber.textContent = belowSum
          } else {
            mobileBelow.classList.add('hidden')
            mobileBelow.classList.remove('flex')
          }
        }
      } else {
        // Hide mobile, show desktop
        if (mobileContainer) {
          mobileContainer.classList.add('hidden')
          mobileContainer.classList.remove('flex')
        }
        if (desktopContainer) {
          desktopContainer.classList.remove('hidden')
        }

        // Update desktop buttons independently
        if (trackerAbove && aboveNumber) {
          if (aboveSum > 0) {
            trackerAbove.classList.remove('hidden')
            trackerAbove.classList.add('flex')
            aboveNumber.textContent = aboveSum
          } else {
            trackerAbove.classList.add('hidden')
            trackerAbove.classList.remove('flex')
          }
        }

        if (trackerBelow && belowNumber) {
          if (belowSum > 0) {
            trackerBelow.classList.remove('hidden')
            trackerBelow.classList.add('flex')
            belowNumber.textContent = belowSum
          } else {
            trackerBelow.classList.add('hidden')
            trackerBelow.classList.remove('flex')
          }
        }
      }
    }

    scrollToNearest(forceDirection = null) {
      if (!forceDirection) return

      const viewportTop = window.scrollY
      const viewportBottom = viewportTop + window.innerHeight

      let targetElement = null
      let bestDistance = Infinity

      this.elements.forEach(({ element, value }) => {
        const rect = element.getBoundingClientRect()
        const elementTop = rect.top + window.scrollY
        const elementBottom = elementTop + rect.height

        // Check if element is in the direction we're looking for
        if (forceDirection === 'above' && elementBottom < viewportTop) {
          // Find the closest element above viewport
          const distance = viewportTop - elementBottom
          if (distance < bestDistance) {
            bestDistance = distance
            targetElement = element
          }
        } else if (forceDirection === 'below' && elementTop > viewportBottom) {
          // Find the closest element below viewport
          const distance = elementTop - viewportBottom
          if (distance < bestDistance) {
            bestDistance = distance
            targetElement = element
          }
        }
      })

      if (targetElement) {
        // Get the grandparent element
        const grandparent = targetElement.parentElement?.parentElement
        if (grandparent) {
          const rect = grandparent.getBoundingClientRect()
          const scrollTop =
            window.pageYOffset || document.documentElement.scrollTop
          const targetY = scrollTop + rect.top - 80 // 80px offset from top

          window.scrollTo({
            top: targetY,
            behavior: 'smooth'
          })
        }
      }
    }
  }

  // Initialize the position tracker and make it globally accessible
  window.positionTracker = new PositionTracker()
})
