import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "poemContent",
    "addCommentButton",
    "form",
    "startPosition",
    "endPosition",
  ]

  startRef = 0
  endRef = 0
  savedRange = null
  markElement = null

  connect() {
    console.log("Poems controller connected")
    document.addEventListener("selectionchange", this.getSelection.bind(this))
  }

  getSelection() {
    const selection = window.getSelection().toString()
    const anchorNode = window.getSelection().anchorNode
    const focusNode = window.getSelection().focusNode

    // Ensure the selection is within this controller's element
    if (
      !this.poemContentTarget.contains(anchorNode) ||
      !this.poemContentTarget.contains(focusNode) ||
      selection.length === 0 ||
      this.markElement
    ) {
      this.addCommentButtonTarget.classList.add("hidden")
      return
    }

    const range = window.getSelection().getRangeAt(0)

    this.startRef = range.startOffset
    this.endRef = range.endOffset
    this.savedRange = range.cloneRange()
    this.addCommentButtonTarget.classList.remove("hidden")
  }

  handleClick() {
    if (this.formTarget.classList.contains("hidden")) {
      this.formTarget.classList.remove("hidden")
      this.highlighted = true
      const highlight = document.createElement("mark")
      this.markElement = highlight
      this.savedRange.surroundContents(highlight)
    } else {
      this.formTarget.classList.add("hidden")
      this.savedRange = null
    }
  }

  handleSubmit() {
    this.startPositionTarget.value = this.startRef
    this.endPositionTarget.value = this.endRef
    this.formTarget.classList.add("hidden")
    this.savedRange = null
    if (this.markElement) {
      const parent = this.markElement.parentNode
      while (this.markElement.firstChild) {
        parent.insertBefore(this.markElement.firstChild, this.markElement)
      }
      parent.removeChild(this.markElement)
      this.markElement = null
    }
  }

  handleCancel() {
    this.formTarget.classList.add("hidden")
    this.savedRange = null
    this.addCommentButtonTarget.classList.add("hidden")
    if (this.markElement) {
      const parent = this.markElement.parentNode
      while (this.markElement.firstChild) {
        parent.insertBefore(this.markElement.firstChild, this.markElement)
      }
      parent.removeChild(this.markElement)
      this.markElement = null
    }
  }
}
