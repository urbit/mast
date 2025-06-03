const footnotes = {}

window.marked.use({
  extensions: [
    {
      name: 'footnote-definition',
      level: 'block',
      start(src) {
        const match = src.match(/\[\^.+?\]:/)
        return match?.index
      },
      tokenizer(src) {
        const rule = /^\[\^(.+?)\]: (.+)/
        const match = rule.exec(src)
        if (match) {
          footnotes[match[1]] = match[2]
          return {
            type: 'footnote-definition',
            raw: match[0],
            tokens: []
          }
        }
      },
      renderer() {
        return ''
      }
    },
    {
      name: 'footnote-ref',
      level: 'inline',
      start(src) {
        return src.match(/\[\^.+?\]/)?.index
      },
      tokenizer(src) {
        const rule = /^\[\^(.+?)\]/
        const match = rule.exec(src)
        if (match) {
          return {
            type: 'footnote-ref',
            raw: match[0],
            text: match[1]
          }
        }
      },
      renderer(token) {
        const id = token.text
        const content = footnotes[id] || '(missing footnote)'
        return `<sup id="fnref:${id}" class="footnote"><a href="#fn:${id}" title="${content}">${id}</a></sup>`
      }
    }
  ]
})
