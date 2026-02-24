// controllers/status_filter_controller.js
// Highlights the active filter button and submits instantly on change

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    this.highlightActive()
  }

  filter(event) {
    event.preventDefault()
    const url = event.currentTarget.dataset.url
    window.Turbo.visit(url)
  }

  highlightActive() {
    const params = new URLSearchParams(window.location.search)
    const current = params.get("status") || ""

    this.buttonTargets.forEach((btn) => {
      const btnStatus = btn.dataset.status || ""
      if (btnStatus === current) {
        btn.setAttribute("data-active", "true")
      } else {
        btn.removeAttribute("data-active")
      }
    })
  }
}
