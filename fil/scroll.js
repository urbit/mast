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

        const isOutOfView = !entry.isIntersecting // grandparent out of view
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
    const elements = Array.from(document.querySelectorAll('.post-container'))
    if (!elements.length) return

    if (e.key === 'j') {
      if (currentIndex < elements.length - 1) {
        scrollToIndex(currentIndex + 1)
      }
    } else if (e.key === 'k') {
      // Move to previous element
      if (currentIndex > 0) {
        scrollToIndex(currentIndex - 1)
      }
    }
  })

  window.scrollToElementCenter = function (id) {
    const el = document.getElementById(id)
    const parent = el?.parentElement?.parentElement

    if (!parent) return

    const rect = parent.getBoundingClientRect()
    const scrollTop = window.pageYOffset || document.documentElement.scrollTop
    const targetY =
      scrollTop +
      rect.top -
      50 /
        window.scrollTo({
          top: targetY,
          behavior: 'smooth'
        })

    const elements = Array.from(
      Array.from(document.querySelectorAll('.post-container'))
    )
    const index = elements.indexOf(parent.querySelector('.post-container'))
    if (index !== -1) currentIndex = index
  }

  window.delayedScrollToCenter = function (id, delay = 200) {
    setTimeout(() => {
      window.scrollToElementCenter(id)
    }, delay)
  }
})
