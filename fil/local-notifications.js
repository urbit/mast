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
          'bg-gray-950 border md:border-[var(--grey-default)] border-[var(--grey-default)] hover:border-[var(--grey-light)] rounded p-2 font-inter text-sm md:text-[var(--grey-default)] text-[var(--grey-default)] hover:text-[var(--grey-light)] hidden items-center gap-1 cursor-pointer z-50 h-[28px]'

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
