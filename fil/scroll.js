document.addEventListener('DOMContentLoaded', async () => {
  const debounce = (func, delay) => {
    let timeoutId
    return (...args) => {
      clearTimeout(timeoutId)
      timeoutId = setTimeout(() => func.apply(null, args), delay)
    }
  }

  const scrollToSelectedPost = () => {
    const postContainers = document.querySelectorAll('.post-node-container')

    for (const container of postContainers) {
      if (container.classList.contains('selected')) {
        const rect = container.getBoundingClientRect()
        const scrollTop =
          window.pageYOffset || document.documentElement.scrollTop
        const targetY = scrollTop + rect.top - 70

        window.scrollTo({
          top: targetY,
          behavior: 'smooth'
        })
        initialLoadComplete = true
        break
      }
    }
  }

  // Call on page load
  window.addEventListener('load', scrollToSelectedPost)
  window.addEventListener('load', () => {
    // Add a small delay to ensure scrollToSelectedPost completes
    setTimeout(() => {
      initialLoadComplete = true
    }, 1000)
  })

  const savePosition = debounce((position) => {
    const postContainers = document.querySelectorAll('.post-node-container')

    for (const container of postContainers) {
      const rect = container.getBoundingClientRect()

      if (rect.top >= 60 && rect.bottom > 0) {
        selectedPostContainer = container
        break
      }
    }

    if (selectedPostContainer) {
      const formSelectedChange =
        selectedPostContainer.querySelector('.submit-selected')
      if (formSelectedChange) {
        const submitEvent = new Event('submit', {
          bubbles: true,
          cancelable: true
        })
        formSelectedChange.dispatchEvent(submitEvent)
      }
    }
  }, 800)

  // On scroll/position change
  window.addEventListener('scroll', () => {
    if (initialLoadComplete) {
      const scrollPosition = window.scrollY
      savePosition(scrollPosition)
    }
  })

  function getPostElements() {
    return Array.from(document.querySelectorAll('.post-container'))
  }
  let currentFocus = ''

  function getPostElements(filterPosition = null) {
    const posts = Array.from(document.querySelectorAll('.post-container'))

    if (!filterPosition) return posts

    const HEADER_HEIGHT = 70

    return posts.filter((element) => {
      const rect = element.getBoundingClientRect()
      return filterPosition === 'above'
        ? rect.bottom < HEADER_HEIGHT
        : rect.top >= HEADER_HEIGHT
    })
  }

  function scrollInDirection(direction) {
    if (!direction) return

    const HEADER_HEIGHT = 69
    const allPosts = Array.from(document.querySelectorAll('.post-container'))
    const currentTarget = document.querySelector('.target')
    const currentTargetIndex = allPosts.indexOf(currentTarget)

    let nextIndex

    if (direction === 'above') {
      const elementsAbove = getPostElements('above')

      if (
        currentTarget &&
        currentTarget.getBoundingClientRect().top >= HEADER_HEIGHT
      ) {
        nextIndex = currentTargetIndex - 1
      } else if (elementsAbove.length > 0) {
        nextIndex = allPosts.indexOf(elementsAbove[elementsAbove.length - 1])
      } else {
        nextIndex = allPosts.length - 1
      }

      if (nextIndex < 0) nextIndex = allPosts.length - 1
    } else {
      const elementsBelow = getPostElements('below')

      if (elementsBelow.length > 0) {
        const firstBelowIndex = allPosts.indexOf(elementsBelow[0])
        nextIndex =
          firstBelowIndex > currentTargetIndex
            ? firstBelowIndex
            : currentTargetIndex + 1
      } else {
        nextIndex = currentTargetIndex + 1
      }

      if (nextIndex >= allPosts.length) nextIndex = 0
    }

    const nextElement = allPosts[nextIndex]
    if (!nextElement) return

    // Update target class
    document
      .querySelectorAll('.target')
      .forEach((el) => el.classList.remove('target'))
    nextElement.classList.add('target')

    const virtualScroller = document.querySelector('virtual-scroller')

    // Scroll to element
    const rect = nextElement.getBoundingClientRect()
    const targetY = window.pageYOffset + rect.top //- HEADER_HEIGHT
    console.log('targetY', targetY)

    if (virtualScroller) {
      virtualScroller.scrollTo({
        top: targetY,
        behavior: 'smooth'
      })
    } else {
      window.scrollTo({
        top: targetY,
        behavior: 'smooth'
      })
    }
  }

  //  Mobile

  // function scrollToDirection(forceDirection = null) {
  //   if (!forceDirection) return

  //   // No target element found, scroll to next viewport
  //   const currentScrollY = window.scrollY
  //   const viewportHeight = window.innerHeight

  //   if (forceDirection === 'above') {
  //     // Scroll up by one viewport height
  //     window.scrollTo({
  //       top: Math.max(0, currentScrollY - viewportHeight + 157),
  //       behavior: 'smooth'
  //     })
  //   } else if (forceDirection === 'below') {
  //     // Scroll down by one viewport height
  //     const maxScroll =
  //       document.documentElement.scrollHeight - window.innerHeight
  //     window.scrollTo({
  //       top: Math.min(maxScroll, currentScrollY + viewportHeight - 157),
  //       behavior: 'smooth'
  //     })
  //   }
  // }

  // let startX = 0
  // let startY = 0
  // let startTime = 0

  // document.addEventListener(
  //   'touchstart',
  //   (e) => {
  //     const touch = e.touches[0]
  //     startX = touch.clientX
  //     startY = touch.clientY
  //     startTime = Date.now()
  //   },
  //   { passive: false }
  // )

  // document.addEventListener(
  //   'touchmove',
  //   (e) => {
  //     // Prevent native scrolling during potential swipes
  //     const deltaTime = Date.now() - startTime
  //     if (deltaTime < 300) {
  //       const touch = e.touches[0]
  //       const deltaX = touch.clientX - startX
  //       const deltaY = touch.clientY - startY
  //       const distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY)

  //       if (distance > 10 && Math.abs(deltaX) < Math.abs(deltaY)) {
  //         e.preventDefault() // Stop native scroll for vertical swipes
  //       }
  //     }
  //   },
  //   { passive: false }
  // )

  // document.addEventListener(
  //   'touchend',
  //   (e) => {
  //     const touch = e.changedTouches[0]
  //     const endX = touch.clientX
  //     const endY = touch.clientY
  //     const endTime = Date.now()

  //     const deltaX = endX - startX
  //     const deltaY = endY - startY
  //     const deltaTime = endTime - startTime

  //     // Check if it's a quick swipe (under 300ms)
  //     if (deltaTime < 300) {
  //       const distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY)

  //       // Minimum distance for swipe (50px)
  //       if (distance > 50) {
  //         // Determine direction
  //         if (Math.abs(deltaX) < Math.abs(deltaY)) {
  //           if (e.cancelable) {
  //             e.preventDefault()
  //           }
  //           // Vertical swipe
  //           if (deltaY > 0) {
  //             // Handle swipe down
  //             scrollToDirection('above')
  //           } else {
  //             // Handle swipe up
  //             scrollToDirection('below')
  //           }
  //         }
  //       }
  //     }
  //   },
  //   { passive: false }
  // )

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

      const actualId = id.substring(6)
      const target = document.getElementById('post-' + actualId)
      let alreadyTarget = false
      if (target) {
        alreadyTarget = target.classList.contains('target')
      }

      document
        .querySelectorAll('.target')
        .forEach((el) => el.classList.remove('target'))

      if (target && !alreadyTarget) {
        target.classList.add('target')
      }
    }
  }

  window.submitFormWithIds = function () {
    const bundleElements = document.querySelectorAll('.bundle')
    const idArray = Array.from(bundleElements)
      .map((element) => element.id)
      .filter((id) => id)

    const elem = document.getElementsByName('id-array')[0]
    elem.setAttribute('value', JSON.stringify(idArray))
    const form = elem.closest('form')
    form.dispatchEvent(new Event('submit', { bubbles: true }))
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

  // Handles removing main form on reply or edit input focus
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
})
