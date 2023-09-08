// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
import "popper"
import "bootstrap"
import "jquery"
import "jquery_ujs"
import "custom"
import "trix"
import "@rails/actiontext"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
