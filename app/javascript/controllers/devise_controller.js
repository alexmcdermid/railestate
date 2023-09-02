import { Controller } from "@hotwired/stimulus"

export default class extends Controller {  
  connect() {
    this.removeAlert('notice')
    this.removeAlert('success')
    this.removeAlert('alert')
  }
  
  removeAlert(elementId) {
    const element = document.getElementById(elementId)
    if (element) {
      setTimeout(function() {
        element.classList.add('hidden')
      }, 5000);
    }
  }
}
