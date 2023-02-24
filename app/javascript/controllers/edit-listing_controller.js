import { Controller } from "@hotwired/stimulus"

export default class extends Controller {  
  connect() {
    this.element.addEventListener("click", () => {
      this.editListing()
    })
  }
  editListing() {
    const button = document.getElementsByClassName("edit_listing_button_"+this.element.id)[0]
    const frame = document.getElementById("edit_listing_"+this.element.id)
    const path = this.element.dataset.path
    if (button.classList.contains("pending")) {
      button.innerHTML = "Edit Listing"
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
