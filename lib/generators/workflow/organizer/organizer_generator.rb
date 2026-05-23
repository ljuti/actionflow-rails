# frozen_string_literal: true

require "rails/generators/base"

module Workflow
  module Generators
    class OrganizerGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      argument :steps, type: :array, default: [], banner: "step step ..."

      def create_organizer_file
        template "organizer.rb.tt", File.join("app", "actions", class_path, "#{file_name}_organizer.rb")
      end

      hook_for :test_framework
    end
  end
end
