import { Controller } from "@hotwired/stimulus"

export default class extends Controller {  
  connect() {
    console.log('submit controller conntected')
    this.element.addEventListener("click", () => {
      this.submit()
    });
  }

  submit() {
    console.log('submitting')
    document.addEventListener("turbo:submit-end", () => {
      const button = document.getElementById("new_listing_button")
      const frame = document.getElementById("new_listing")
      if (button.classList.contains("pending")) {
        button.innerHTML = "New Listing"
        button.classList.remove('pending')
        frame.src = ""
        frame.innerHTML = ""
      }
    })
  }
}
