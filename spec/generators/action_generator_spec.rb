# frozen_string_literal: true

require "spec_helper"
require "rails/generators"
require "tmpdir"
require "actionflow/rails/generators"

RSpec.describe "workflow:action generator" do
  before do
    @tmpdir = File.join(Dir.tmpdir, "actionflow_gen_test_#{$$}")
    FileUtils.mkdir_p(@tmpdir)
    @gen = Workflow::Generators::ActionGenerator.new(
      ["charge_card", "user", "amount"],
      promises: ["charge"],
      destination_root: @tmpdir
    )
    @gen.destination_root = @tmpdir
  end

  after do
    FileUtils.rm_rf(@tmpdir)
  end

  it "generates an action file with expects and promises" do
    @gen.invoke_all

    generated = File.read(File.join(@tmpdir, "app", "actions", "charge_card_action.rb"))
    expect(generated).to include("class ChargeCardAction")
    expect(generated).to include("include Workflow::Action")
    expect(generated).to include("expects :user")
    expect(generated).to include("expects :amount")
    expect(generated).to include("promises :charge")
    expect(generated).to include("def call(ctx)")
  end

  it "generates an action with no contract keys" do
    gen = Workflow::Generators::ActionGenerator.new(["notify_admin"])
    gen.destination_root = @tmpdir
    gen.invoke_all

    generated = File.read(File.join(@tmpdir, "app", "actions", "notify_admin_action.rb"))
    expect(generated).to include("class NotifyAdminAction")
    expect(generated).to include("def call(ctx)")
  end

  it "generates namespaced actions" do
    gen = Workflow::Generators::ActionGenerator.new(["billing/process_payment"])
    gen.destination_root = @tmpdir
    gen.invoke_all

    path = File.join(@tmpdir, "app", "actions", "billing", "process_payment_action.rb")
    expect(File.exist?(path)).to be(true)
    generated = File.read(path)
    expect(generated).to include("class Billing::ProcessPaymentAction")
  end
end
