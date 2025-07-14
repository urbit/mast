document.addEventListener('DOMContentLoaded', () => {
  const trackedElements = new Set()
  const lastStates = new Map()

  function getPostElements() {
    return Array.from(document.querySelectorAll('.post-container'))
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
    const elements = Array.from(document.querySelectorAll('.track-visibility'))

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

  let isManualScroll = true
  let currentFocus = ''

  function getElementClosestToViewportTop() {
    const elements = getPostElements()
    let closestIndex = -1
    let smallestDistance = Infinity

    elements.forEach((el, index) => {
      const rect = el.getBoundingClientRect()
      const elementTop = rect.top

      // Only consider elements that are at or below the viewport top (not above)
      if (elementTop >= 0) {
        const distance = elementTop

        if (distance < smallestDistance) {
          smallestDistance = distance
          closestIndex = index
        }
      }
    })
    return elements[closestIndex].id
  }

  let scrollTimer = null

  // let scrollTimeout
  // window.addEventListener('scroll', () => {
  //   console.log('trying to run scroll event detected')
  //   if (isManualScroll == false) return
  //   console.log('updating current focus')
  //   clearTimeout(scrollTimeout)
  //   scrollTimeout = setTimeout(() => {
  //     currentFocus = getElementClosestToViewportTop()
  //     console.log('new id focus after scroll:', currentFocus)
  //   }, 50)
  // })

  function scrollToNearest(forceDirection = null) {
    if (!forceDirection) return

    const viewportTop = window.scrollY + 60
    const viewportBottom = viewportTop + window.innerHeight

    let targetElement = null
    let bestDistance = Infinity

    let elements = Array.from(document.querySelectorAll('.has-new'))

    elements.forEach((element) => {
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
      } else if (
        forceDirection === 'above' &&
        elementBottom > viewportTop &&
        elementTop < viewportBottom
      ) {
        // If looking above and element is in viewport, choose from bottom up (bottommost first)
        const distance = viewportBottom - elementBottom
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
      } else if (
        forceDirection === 'below' &&
        elementBottom > viewportTop &&
        elementTop < viewportBottom
      ) {
        // If looking below and element is in viewport, choose from top to bottom (topmost first)
        const distance = elementTop - viewportTop
        if (distance < bestDistance) {
          bestDistance = distance
          targetElement = element
        }
      }
    })

    if (targetElement) {
      targetElement.click()

      const rect = targetElement.getBoundingClientRect()
      const scrollTop = window.pageYOffset || document.documentElement.scrollTop
      const targetY = scrollTop + rect.top - 157

      window.scrollTo({
        top: targetY,
        behavior: 'smooth'
      })
    } else {
      // No target element found, scroll to next viewport
      const currentScrollY = window.scrollY
      const viewportHeight = window.innerHeight

      if (forceDirection === 'above') {
        // Scroll up by one viewport height
        window.scrollTo({
          top: Math.max(0, currentScrollY - viewportHeight + 157),
          behavior: 'smooth'
        })
      } else if (forceDirection === 'below') {
        // Scroll down by one viewport height
        const maxScroll =
          document.documentElement.scrollHeight - window.innerHeight
        window.scrollTo({
          top: Math.min(maxScroll, currentScrollY + viewportHeight - 157),
          behavior: 'smooth'
        })
      }
    }
  }

  document.addEventListener('keydown', (e) => {
    const tag = document.activeElement?.tagName?.toLowerCase()
    if (
      ['input', 'textarea'].includes(tag) ||
      document.activeElement?.isContentEditable
    ) {
      return
    }

    if (e.key === 'j' || e.key === ' ') {
      e.preventDefault()
      scrollToNearest('below')
    } else if (e.key === 'k') {
      e.preventDefault()
      scrollToNearest('above')
    }
  })

  //  Handles scroll to the top for new replies and reply form

  window.scrollToElementTop = function (id, getParent) {
    const el = document.getElementById(id)

    const elem = getParent ? el?.parentElement?.parentElement : el

    if (!elem) return

    const rect = elem.getBoundingClientRect()
    const scrollTop = window.pageYOffset || document.documentElement.scrollTop
    const targetY = scrollTop + rect.top - 65
    window.scrollTo({
      top: targetY,
      behavior: 'smooth'
    })

    currentFocus = id
  }

  window.toggleView = function (id, togglePostForm = false, hideForms = false) {
    if (hideForms) {
      if (id.startsWith('reply-')) {
        document.querySelectorAll('.reply-form').forEach((el) => {
          if (el.id !== id) {
            el.classList.add('hidden')
            el.classList.add('md:hidden')
          }
        })
        document.querySelectorAll('.edit-form').forEach((el) => {
          el.classList.add('hidden')
          el.classList.add('md:hidden')
        })
      } else if (id.startsWith('edit-')) {
        document.querySelectorAll('.edit-form').forEach((el) => {
          if (el.id !== id) {
            el.classList.add('hidden')
            el.classList.add('md:hidden')
          }
        })
        document.querySelectorAll('.reply-form').forEach((el) => {
          el.classList.add('hidden')
          el.classList.add('md:hidden')
        })
      }
    }

    const el = document.getElementById(id)
    if (el) {
      el.classList.toggle('hidden')
      el.classList.toggle('md:hidden')
      if (!el.classList.contains('hidden')) {
        const textarea = el.querySelector('textarea')
        console.log(el)
        if (textarea) {
          textarea.focus()
        }
      }
      if (togglePostForm) {
        const postForm = document.getElementById('form-post-wrapper')
        if (postForm) {
          if (el.classList.contains('hidden')) {
            postForm.classList.remove('hidden')
            postForm.classList.remove('md:hidden')
          } else {
            postForm.classList.add('hidden')
            postForm.classList.add('md:hidden')
          }
        }
      }
    }
  }

  window.hideClassView = function (className) {
    const elements = document.querySelectorAll('.' + className)
    elements.forEach((el) => {
      el.classList.add('hidden')
      el.classList.add('md:hidden')
    })
  }

  window.toggleClassView = function (className) {
    const elements = document.querySelectorAll('.' + className)
    elements.forEach((el) => {
      el.classList.toggle('hidden')
      el.classList.toggle('md:hidden')
    })
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
          'bg-gray-950 border md:border-[var(--grey-default)] border-[var(--grey-light)] hover:border-[var(--grey-light)] rounded p-2 font-inter text-sm md:text-[var(--grey-default)] text-[var(--grey-light)] hover:text-[var(--grey-light)] hidden items-center gap-1 cursor-pointer z-50 h-[28px]'

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

        trackerAbove?.addEventListener('click', () => {
          const event = new CustomEvent('click/toggle-hide')
          document.dispatchEvent(event)
          this.scrollToNearest('above')
        })
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
      const viewportTop = window.scrollY + 60
      const viewportBottom = viewportTop + window.innerHeight - 110

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

      const viewportTop = window.scrollY + 60
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
        const container =
          targetElement.parentElement?.parentElement?.parentElement
            ?.parentElement
        if (container) {
          container.click()

          const rect = container.getBoundingClientRect()
          const scrollTop =
            window.pageYOffset || document.documentElement.scrollTop
          const targetY = scrollTop + rect.top - 70

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
