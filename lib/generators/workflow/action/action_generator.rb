# frozen_string_literal: true

require "rails/generators/base"

module Workflow
  module Generators
    class ActionGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      argument :expects, type: :array, default: [], banner: "key key ..."

      class_option :promises, type: :array, default: [], desc: "Keys this action promises"

      def create_action_file
        template "action.rb.tt", File.join("app", "actions", class_path, "#{file_name}_action.rb")
      end

      hook_for :test_framework
    end
  end
end
