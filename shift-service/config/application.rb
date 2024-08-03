# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_text/engine'
require 'action_cable/engine'

Bundler.require(*Rails.groups)

module ShiftService
  class Application < Rails::Application
    config.load_defaults 7.1

    config.api_only = true
    config.eager_load_paths << File.join(config.root, '/lib')

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
