import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "poemContent",
    "addCommentButton",
    "form",
    "updateForm",
    "startPosition",
    "endPosition",
  ]

  startRef = 0
  endRef = 0
  poemId = null
  savedRange = null
  markElement = null
  prevComment = null

  getLinearOffset(container, node, offset) {
    let linearOffset = 0
    const walker = document.createTreeWalker(
      container,
      NodeFilter.SHOW_TEXT,
      null,
      false
    )
    while (walker.nextNode()) {
      if (walker.currentNode === node) {
        linearOffset += offset
        break
      } else {
        linearOffset += walker.currentNode.textContent.length
      }
    }
    return linearOffset
  }

  connect() {
    console.log("Poems controller connected")
    document.addEventListener("selectionchange", this.getSelection.bind(this))
    this.poemId = this.poemContentTarget.id.split("-")[1]
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
    const sel = window.getSelection()

    this.startRef = this.getLinearOffset(
      this.poemContentTarget,
      range.startContainer,
      range.startOffset
    )
    this.endRef = this.getLinearOffset(
      this.poemContentTarget,
      range.endContainer,
      range.endOffset
    )
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
      const documentFormField = document.getElementById("comment-field-new").querySelector("input[name='comment[content]']")
      documentFormField.value = ""
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
    this.updateFormTarget.classList.add("hidden")
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

  showComment(event) {
    const commentId = event.currentTarget.id.split("-")[1]
    const commentElement = document.getElementById(`comment-${commentId}`)
    if (commentElement.classList.contains("hidden")) {
      commentElement.classList.remove("hidden")
      if (this.prevComment && this.prevComment !== commentElement) {
        this.prevComment.classList.add("hidden")
      }
      this.prevComment = commentElement
    } else {
      commentElement.classList.add("hidden")
      this.prevComment = null
    }
  }

  hideComment(event) {
    const commentId = event.currentTarget.id.split("-")[1]
    const commentElement = document.getElementById(`comment-${commentId}`)
    commentElement.classList.add("hidden")
  }

  handleEdit(event) {
    const commentId = event.currentTarget.id.split("-")[1]
    const commentElement = document.getElementById(`comment-${commentId}`)
    const commentText = commentElement.querySelector(".comment-text").innerText

    this.hideComment(event)

    // Populate the update form
    this.updateFormTarget.action = `/poems/${this.poemId}/comments/${commentId}`
    this.updateFormTarget.querySelector(
      'input[name="comment[content]"]'
    ).value = commentText

    if (this.updateFormTarget.classList.contains("hidden")) {
      console.log("Showing update form")
      this.updateFormTarget.classList.remove("hidden")
    }
  }
}
