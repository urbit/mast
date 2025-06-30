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
})
