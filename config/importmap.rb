# config/importmap.rb
# Pin JS modules to their source files.
# During assets:precompile, Propshaft fingerprints these paths and
# bakes the manifest into public/assets/importmap.json.

pin "application"                                          # app/assets/javascripts/application.js
pin "@hotwired/turbo-rails", to: "turbo.min.js",  preload: true
pin "@hotwired/stimulus",    to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
