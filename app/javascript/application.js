// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import "./previews"

import jquery from "jquery"
window.$ = window.jQuery = jquery
window.bootstrap = require("bootstrap")
