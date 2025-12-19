require_relative "boot"

require "rails/all"
require "logger"

Bundler.require(*Rails.groups)

module QuizManager
  class Application < Rails::Application
    config.load_defaults 6.1

    config.time_zone = "Asia/Kolkata"
    config.active_record.default_timezone = :utc

    config.assets.initialize_on_precompile = false
  end
end
