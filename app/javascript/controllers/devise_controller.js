import { Controller } from "@hotwired/stimulus"

export default class extends Controller {  
  connect() {
    console.log('devise controller conntected')
    this.removeAlert()
  }
  
  removeAlert() {
    const notice = document.getElementById('notice')
    setTimeout(function() {
      notice.classList.add('hidden')
    }, 5000);
  }
}
