import { Controller } from "@hotwired/stimulus"

export default class extends Controller {  
  connect() {
    this.element.addEventListener("click", () => {
      this.newListing()
    })
  }
  newListing() {
    const button = document.getElementById("new_listing_button")
    const frame = document.getElementById("new_listing")
    const path = this.element.dataset.path
    if (button.classList.contains("pending")) {
      button.innerHTML = "New Listing"
      button.classList.remove('pending')
      frame.src = ""
      frame.innerHTML = ""
    } else {
      button.innerHTML = "Cancel"
      button.classList.add('pending')
      frame.src = path
      frame.reload()
    }
  }
}
