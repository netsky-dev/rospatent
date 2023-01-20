require "rspec"
require "webmock/rspec"
require "json"
require_relative "../lib/rospatent/api_request_decorator.rb"

RSpec.describe Rospatent::ApiRequestDecorator do
  let(:api_key) { "test_api_key" }
  let(:path) { "/profiles/current/" }

  describe ".get_response" do
    before do
      stub_request(:get, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_data" }.to_json)
    end

    it "returns the expected response" do
      response = described_class.get_response(path, api_key)
      expect(response).to eq({ "data" => "test_data" })
    end
  end

  describe ".post_response" do
    let(:payload) { { "test_key" => "test_value" } }

    before do
      stub_request(:post, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" }, body: payload.to_json)
        .to_return(status: 200, body: { data: "test_data" }.to_json)
    end

    it "returns the expected response" do
      response = described_class.post_response(path, api_key, payload)
      expect(response).to eq({ "data" => "test_data" })
    end
  end

  describe ".put_response" do
    let(:payload) { { "test_key" => "test_value" } }

    before do
      stub_request(:put, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" }, body: payload.to_json)
        .to_return(status: 200, body: { data: "test_data" }.to_json)
    end

    it "returns the expected response" do
      response = described_class.put_response(path, api_key, payload)
      expect(response).to eq({ "data" => "test_data" })
    end
  end
end
