require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Schedule
  class Application < Rails::Application
    #config.time_zone = 'Ekaterinburg'
    config.i18n.default_locale = :ru
    config.active_record.raise_in_transactional_callbacks = true
  end
end