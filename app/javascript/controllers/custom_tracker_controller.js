import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "url", "iframe" ]

  connect() {
    // this.element.textContent = "Hello World!"
  }
  changeUrl (event) {
    this.iframeTarget.src = this.urlTarget.value;
    event.preventDefault();

  }
}
