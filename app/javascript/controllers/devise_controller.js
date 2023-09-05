import { Controller } from "@hotwired/stimulus"

export default class extends Controller {  
  connect() {
    const notificationWrapper = document.querySelector('#notification-wrapper');
    this.animateAlert(notificationWrapper);
    this.removeAlert('notice')
    this.removeAlert('success')
    this.removeAlert('alert')
  }

  animateAlert(notification) {
    // Initial setup
    notification.classList.remove('invisible', 'animate-float-up');
    notification.classList.add('top-0', 'animate-float-down');

    // Move to top-20
    setTimeout(() => {
      notification.classList.remove('animate-float-down');
      notification.classList.add('top-20');
    }, 1000);

    // Prepare for the move back to top-0
    setTimeout(() => {
      notification.classList.remove('top-20');
      notification.classList.add('top-0', 'animate-float-up');
    }, 3000);

    // Hide
    setTimeout(() => {
      notification.classList.add('invisible');
      notification.classList.remove('animate-float-up');
    }, 4000);
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
