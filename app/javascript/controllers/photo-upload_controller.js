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
        } else {
          alert(data.error); 
          console.log(data.error)
        }
      });
    })
    .catch(error => {
      console.error("Request failed:", error);
    });    
  }
}
