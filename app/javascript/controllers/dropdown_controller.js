import { Controller } from "@hotwired/stimulus"
// For dropdown menus
// Content is hidden by default and shown on calling show content
// Hide content should be called on focus out
export default class extends Controller {
  static targets = [ "content" ]
  showContent (_event) {
    this.contentTarget.hidden = false;
    this.contentTarget.firstElementChild.focus()
  }
  hideContent (event) {
    // So that can navigate with keyboard
    const targetIsInsideDropdown = this.contentTarget.contains(event.relatedTarget);

    if (!targetIsInsideDropdown){
      this.contentTarget.hidden = true;
      console.log("HElo")
    }
  }
}
