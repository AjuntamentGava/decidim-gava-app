# frozen_string_literal: true

require "rails_helper"

describe EphemeralCensusAuthorizationHandler do
  subject(:handler) { described_class.new }

  it "inherits the census verification" do
    expect(described_class.superclass).to eq(CensusAuthorizationHandler)
  end

  it "exposes the census fields in the form" do
    expect(handler.form_attributes).to include("document_number", "date_of_birth")
    expect(handler.form_attributes).not_to include("tos_agreement")
  end

  it "uses its own handler name" do
    expect(handler.handler_name).to eq("ephemeral_census_authorization_handler")
  end

  it "renders a custom form partial" do
    expect(ApplicationController.new.lookup_context.exists?(handler.to_partial_path, [], true)).to be(true)
  end
end
