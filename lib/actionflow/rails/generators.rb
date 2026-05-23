# frozen_string_literal: true

require "rails/generators"

# Ensure generators are loaded when used in a Rails app
# In a real Rails app, Rails::Engine auto-loads from lib/generators/
# This file is for explicit require in test environments
require_relative "../../generators/workflow/action/action_generator"
require_relative "../../generators/workflow/organizer/organizer_generator"
