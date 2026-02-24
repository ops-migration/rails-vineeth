// application.js
// Entry point for the JavaScript bundle
// Loaded via importmap (config/importmap.rb)

import "@hotwired/turbo-rails"
import "controllers"

// ─── Flash auto-dismiss ────────────────────────────────────────────────────
document.addEventListener("turbo:load", () => {
  const flashes = document.querySelectorAll("[data-flash-auto-dismiss]")
  flashes.forEach((el) => {
    setTimeout(() => {
      el.style.transition = "opacity 400ms ease"
      el.style.opacity = "0"
      setTimeout(() => el.remove(), 420)
    }, 4000)
  })
})

// ─── Active nav link ───────────────────────────────────────────────────────
document.addEventListener("turbo:load", () => {
  const currentPath = window.location.pathname
  document.querySelectorAll("nav a[href]").forEach((link) => {
    const href = link.getAttribute("href")
    if (href === currentPath || (href !== "/" && currentPath.startsWith(href))) {
      link.classList.add("active")
    } else {
      link.classList.remove("active")
    }
  })
})
