// controllers/index.js
// Registers all Stimulus controllers

import { application } from "controllers/application"

// Eager-load all controllers defined in this directory
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
