// controllers/flash_controller.js
// Auto-dismisses flash messages after a timeout

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { delay: { type: Number, default: 4000 } }

  connect() {
    this.timer = setTimeout(() => this.dismiss(), this.delayValue)
  }

  disconnect() {
    clearTimeout(this.timer)
  }

  dismiss() {
    this.element.style.transition = "opacity 400ms ease, max-height 400ms ease"
    this.element.style.opacity = "0"
    this.element.style.maxHeight = "0"
    this.element.style.overflow = "hidden"
    setTimeout(() => this.element.remove(), 420)
  }
}
