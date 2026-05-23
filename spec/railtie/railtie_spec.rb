# frozen_string_literal: true

require "spec_helper"

RSpec.describe Actionflow::Rails::Railtie do
  after do
    Workflow.instance_variable_set(:@configuration, nil)
  end

  it "is a Rails::Railtie subclass" do
    expect(described_class).to be < ::Rails::Railtie
  end

  it "has an actionflow.configuration initializer" do
    names = described_class.initializers.map(&:name)
    expect(names).to include("actionflow.configuration")
  end

  describe "initializer behavior" do
    it "configures logger lambda that calls Rails.logger.info" do
      log_messages = []
      fake_logger = Struct.new(:messages) {
        def info(msg)
          messages << msg
        end
      }.new(log_messages)
      allow(::Rails).to receive(:logger).and_return(fake_logger)

      initializer = described_class.initializers.find { |i| i.name == "actionflow.configuration" }
      initializer.run(double("app"))

      expect(Workflow.configuration.logger).not_to be_nil
      Workflow.configuration.logger.call("test")
      expect(log_messages.last).to eq("test")
    end

    it "skips logger when Rails.logger is nil" do
      allow(::Rails).to receive(:logger).and_return(nil)

      initializer = described_class.initializers.find { |i| i.name == "actionflow.configuration" }
      initializer.run(double("app"))

      expect(Workflow.configuration.logger).to be_nil
    end
  end
end
