require "rspec"
require "webmock/rspec"
require "json"
require_relative "../lib/rospatent/api_request_decorator.rb"

RSpec.describe Rospatent::StatementTypes do
  let(:api_key) { "test_api_key" }
  let(:statement_type_id) { 1 }

  describe ".get_statement_types" do
    let(:path) { "/statement-types/" }
    before do
      stub_request(:get, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_data" }.to_json)
    end

    it "calls ApiRequestDecorator.get_response with the correct path and api_key" do
      expect(Rospatent::ApiRequestDecorator).to receive(:get_response).with(path, api_key)
      described_class.get_statement_types(api_key)
    end

    it "returns the expected response" do
      response = described_class.get_statement_types(api_key)
      expect(response).to eq({ "data" => "test_data" })
    end
  end

  describe ".get_statement_type" do
    let(:statement_type_id) { 1 }
    let(:path) { "/statement-types/#{statement_type_id}/" }
    before do
      stub_request(:get, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_data" }.to_json)
    end
    it "should return the correct data" do
      expect(Rospatent::StatementTypes.get_statement_type(api_key, statement_type_id)).to eq({ "data" => "test_data" })
    end
  end

  describe ".get_statement_type_referred" do
    let(:path) { "/statement-types/#{statement_type_id}/referred/" }
    before do
      stub_request(:get, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_data" }.to_json)
    end

    it "calls ApiRequestDecorator.get_response with the correct path and api_key" do
      expect(Rospatent::ApiRequestDecorator).to receive(:get_response).with(path, api_key)
      described_class.get_statement_type_referred(api_key, statement_type_id)
    end

    it "returns the expected response" do
      response = described_class.get_statement_type_referred(api_key, statement_type_id)
      expect(response).to eq({ "data" => "test_data" })
    end
  end
end
