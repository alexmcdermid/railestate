import { Controller } from "@hotwired/stimulus"

export default class extends Controller {  
  connect() {
    this.element.addEventListener("click", () => {
      this.newListing()
    })
  }
  newListing() {
    console.log('new')
    const frame = document.getElementById("new_listing")
    console.log(frame)
    const path = this.element.dataset.path
    console.log(path)
    frame.src = path
    frame.reload()
  }
}
