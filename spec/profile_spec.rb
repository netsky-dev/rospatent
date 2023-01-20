require "rspec"
require "webmock/rspec"
require "json"
require_relative "../lib/rospatent/api_request_decorator.rb"

RSpec.describe Rospatent::Profile do
  let(:api_key) { "test_api_key" }
  let(:path) { "/profiles/current/" }

  describe ".get_current_profile" do
    before do
      stub_request(:get, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_data" }.to_json)
    end

    it "calls ApiRequestDecorator.get_response with the correct path and api_key" do
      expect(Rospatent::ApiRequestDecorator).to receive(:get_response).with(path, api_key)
      described_class.get_current_profile(api_key)
    end

    it "returns the expected response" do
      response = described_class.get_current_profile(api_key)
      expect(response).to eq({ "data" => "test_data" })
    end
  end
end
