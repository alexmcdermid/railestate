import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  connect() {
    this.inputTarget.style.opacity = 0
    this.inputTarget.style.position = "absolute"
    this.inputTarget.style.top = 0
    this.inputTarget.style.left = 0
    this.inputTarget.style.width = 0
    this.inputTarget.style.height = 0
  }

  chooseFile() {
    this.inputTarget.click();
    const fileNameSpan = this.element.querySelector("#file-name-span");
    this.inputTarget.addEventListener("change", (event) => {
      const fileName = event.target.value.split("\\").pop();
      fileNameSpan.textContent = fileName;
    });
  }

  uploadFile() {
    const file = this.inputTarget.files[0]
    const formData = new FormData()
    formData.append("photo[image]", file)
    formData.append("photo[listing_id]", this.data.get("listingId"))

    fetch(this.data.get("url"), {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": this.data.get("csrfToken"),
      },
    })
    .then(response => {
      return response.json().then(data => {
        if (response.ok) {
          const inputField = document.querySelector('#listing_image_url');
          inputField.value = data.url;
          this.flashMessage("Upload successful!", "success");
        } else {
          this.flashMessage(data.error, "error");
          console.log(data.error)
        }
      });
    })
    .catch(error => {
      console.error("Request failed:", error);
      this.flashMessage("An unexpected error occurred.", "error");
    });    
  }

  flashMessage(message, type = "success") {
    const alertDiv = document.getElementById('alert');
    
    alertDiv.className = 'py-2 px-3 mb-5 font-medium rounded-lg inline-block';
  
    if (type === "success") {
      alertDiv.classList.add('bg-green-50', 'text-green-500');
    } else if (type === "error") {
      alertDiv.classList.add('bg-red-50', 'text-red-500');
    }
  
    alertDiv.textContent = message;
    alertDiv.classList.remove('hidden');
  
    setTimeout(() => {
      alertDiv.classList.add('hidden');
    }, 3000);
  }
}
