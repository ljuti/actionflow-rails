# frozen_string_literal: true

require "active_support/core_ext/module/delegation"
require "actionflow"
require_relative "actionflow/rails/version"
require_relative "actionflow/rails/railtie"

module Actionflow
  module Rails
    class Error < StandardError; end
  end
end
