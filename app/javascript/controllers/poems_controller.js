import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    static targets = ["poemContent", "addCommentButton", "form", "startPosition", "endPosition"];

    startRef = 0;
    endRef = 0;

    connect() {
        console.log("Poems controller connected");
        document.addEventListener("selectionchange", this.getSelection.bind(this));
    }

    getSelection() {
        const selection = window.getSelection().toString();
        const anchorNode = window.getSelection().anchorNode;
        const focusNode = window.getSelection().focusNode;
        
        // Ensure the selection is within this controller's element
        if (!this.poemContentTarget.contains(anchorNode) || !this.poemContentTarget.contains(focusNode) || selection.length === 0) {
            this.addCommentButtonTarget.classList.add("hidden");
            return; 
        }

        this.startRef = window.getSelection().getRangeAt(0).startOffset;
        this.endRef = window.getSelection().getRangeAt(0).endOffset;
        this.addCommentButtonTarget.classList.remove("hidden");
    }

    handleClick() {
        if (this.formTarget.classList.contains("hidden")) {
            this.formTarget.classList.remove("hidden");
        }
        else {
            this.formTarget.classList.add("hidden");
        }
    }

    handleSubmit(event) {
        this.startPositionTarget.value = this.startRef;
        this.endPositionTarget.value = this.endRef;
    }

}