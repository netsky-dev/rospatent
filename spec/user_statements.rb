require "rspec"
require "webmock/rspec"
require_relative "user_statements"

describe Rospatent::UserStatements do
  let(:api_key) { "test_api_key" }
  let(:base_url) { "https://online.rospatent.gov.ru/external_api" }

  describe ".get_user_statements" do
    let(:is_draft) { false }
    let(:page) { 1 }
    let(:path) { "/user-statements/?is_draft=#{is_draft}&page=#{page}" }

    before do
      stub_request(:get, "#{base_url}#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_data" }.to_json)
    end

    it "sends a get request to the correct path with the correct parameters" do
      described_class.get_user_statements(api_key, is_draft: is_draft, page: page)
      expect(WebMock).to have_requested(:get, "#{base_url}#{path}").once
    end

    it "returns the correct response" do
      response = described_class.get_user_statements(api_key, is_draft: is_draft, page: page)
      expect(response).to eq({ "data" => "test_data" })
    end
  end

  describe ".get_user_statement" do
    let(:statement_id) { 1 }
    let(:path) { "/user-statement/#{statement_id}" }

    before do
      stub_request(:get, "#{base_url}#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_data" }.to_json)
    end

    it "sends a get request to the correct path with the correct parameters" do
      described_class.get_user_statement(api_key, statement_id)
      expect(WebMock).to have_requested(:get, "#{base_url}#{path}").once
    end

    it "returns the correct response" do
      response = described_class.get_user_statement(api_key, statement_id)
      expect(response).to eq({ "data" => "test_data" })
    end
  end

  describe ".get_user_statement_pay" do
    let(:statement_id) { 1 }
    let(:path) { "/user-statement-pay/#{statement_id}" }

    before do
      stub_request(:get, "#{base_url}#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_data" }.to_json)
    end

    it "sends a get request to the correct path with the correct parameters" do
      described_class.get_user_statement_pay(api_key, statement_id)
      expect(WebMock).to have_requested(:get, "#{base_url}#{path}").once
    end

    it "returns the correct response" do
      response = described_class.get_user_statement_pay(api_key, statement_id)
      expect(response).to eq({ "data" => "test_data" })
    end
  end

  describe ".get_download_attachment" do
    let(:path) { "/download-attachment" }

    before do
      stub_request(:get, "#{base_url}#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_data" }.to_json)
    end

    it "sends a get request to the correct path with the correct parameters" do
      described_class.get_download_attachment(api_key)
      expect(WebMock).to have_requested(:get, "#{base_url}#{path}").once
    end

    it "returns the correct response" do
      response = described_class.get_download_attachment(api_key)
      expect(response).to eq({ "data" => "test_data" })
    end
  end
end
