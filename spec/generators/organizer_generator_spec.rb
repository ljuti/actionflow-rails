# frozen_string_literal: true

require "spec_helper"
require "rails/generators"
require "tmpdir"
require "actionflow/rails/generators"

RSpec.describe "workflow:organizer generator" do
  before do
    @tmpdir = File.join(Dir.tmpdir, "actionflow_org_test_#{$$}")
    FileUtils.mkdir_p(@tmpdir)
  end

  after do
    FileUtils.rm_rf(@tmpdir)
  end

  it "generates an organizer file with step composition" do
    gen = Workflow::Generators::OrganizerGenerator.new(
      ["checkout", "validate_cart", "charge_card", "send_receipt"]
    )
    gen.destination_root = @tmpdir
    gen.invoke_all

    generated = File.read(File.join(@tmpdir, "app", "actions", "checkout_organizer.rb"))
    expect(generated).to include("class CheckoutOrganizer")
    expect(generated).to include("include Workflow::Organizer")
    expect(generated).to include("ValidateCartAction.new")
    expect(generated).to include("ChargeCardAction.new")
    expect(generated).to include("SendReceiptAction.new")
    expect(generated).to include("def call")
    expect(generated).to include(".reduce(")
  end

  it "generates an organizer with no steps" do
    gen = Workflow::Generators::OrganizerGenerator.new(["empty_workflow"])
    gen.destination_root = @tmpdir
    gen.invoke_all

    generated = File.read(File.join(@tmpdir, "app", "actions", "empty_workflow_organizer.rb"))
    expect(generated).to include("class EmptyWorkflowOrganizer")
    expect(generated).to include("def call")
  end
end
