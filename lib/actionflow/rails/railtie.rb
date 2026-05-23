# frozen_string_literal: true

require "rails/railtie"

module Actionflow
  module Rails
    class Railtie < ::Rails::Railtie
      initializer "actionflow.configuration" do
        Workflow.configure do |config|
          config.logger = ->(msg) { ::Rails.logger.info(msg) } if ::Rails.logger
        end
      end
    end
  end
end
