import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  goToLink(event) {
    const url = event.currentTarget.dataset.url
    window.location.href = url
  }
}
