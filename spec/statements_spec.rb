require "rspec"
require "webmock/rspec"
require_relative "../lib/rospatent/api_request_decorator"

RSpec.describe Rospatent::Statements do
  let(:api_key) { "test_api_key" }

  describe ".get_user_statements" do
    let(:is_draft) { false }
    let(:page) { 1 }
    let(:path) { "/user-statements/?is_draft=#{is_draft}&page=#{page}" }

    before do
      stub_request(:get, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_data" }.to_json)
    end

    it "sends a get request to the correct path with the correct parameters" do
      described_class.get_user_statements(api_key, is_draft: is_draft, page: page)
      expect(WebMock).to have_requested(:get, "https://online.rospatent.gov.ru/external_api#{path}").once
    end

    it "returns the correct response" do
      response = described_class.get_user_statements(api_key, is_draft: is_draft, page: page)
      expect(response).to eq({ "data" => "test_data" })
    end
  end

  describe ".create_statement" do
    let(:path) { "/statements/" }
    let(:payload) { { statement_type: "test", statement_data: "test_data" } }
    before do
      stub_request(:post, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" }, body: payload.to_json)
        .to_return(status: 201, body: { data: "test_data" }.to_json)
    end

    it "sends a post request to the correct path with the correct parameters" do
      described_class.create_statement(api_key, payload)
      expect(WebMock).to have_requested(:post, "https://online.rospatent.gov.ru/external_api#{path}").once
    end

    it "returns the correct response" do
      response = described_class.create_statement(api_key, payload)
      expect(response).to eq({ "data" => "test_data" })
    end
  end

  describe ".update_statement" do
    let(:path) { "/statements/" }
    let(:payload) { { statement_id: 1, statement_data: "updated_test_data" } }

    before do
      stub_request(:put, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" }, body: payload.to_json)
        .to_return(status: 200, body: { data: "updated_test_data" }.to_json)
    end

    it "sends a put request to the correct path with the correct parameters" do
      described_class.update_statement(api_key, payload)
      expect(WebMock).to have_requested(:put, "https://online.rospatent.gov.ru/external_api#{path}").once
    end

    it "returns the correct response" do
      response = described_class.update_statement(api_key, payload)
      expect(response).to eq({ "data" => "updated_test_data" })
    end
  end

  describe ".create_statement_publication" do
    let(:path) { "/statements/publication/" }
    let(:payload) { { statement_id: 1, publication_data: "test_publication_data" } }

    before do
      stub_request(:post, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" }, body: payload.to_json)
        .to_return(status: 201, body: { data: "test_publication_data" }.to_json)
    end

    it "sends a post request to the correct path with the correct payload" do
      described_class.create_statement_publication(api_key, payload)
      expect(WebMock).to have_requested(:post, "https://online.rospatent.gov.ru/external_api#{path}").with(body: payload.to_json).once
    end

    it "returns the correct response" do
      response = described_class.create_statement_publication(api_key, payload)
      expect(response).to eq({ "data" => "test_publication_data" })
    end
  end

  describe ".get_statement" do
    let(:statement_id) { 1 }
    let(:path) { "/statements/#{statement_id}/" }

    before do
      stub_request(:get, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_statement_data" }.to_json)
    end

    it "sends a get request to the correct path with the correct parameters" do
      described_class.get_statement(api_key, statement_id)
      expect(WebMock).to have_requested(:get, "https://online.rospatent.gov.ru/external_api#{path}").once
    end

    it "returns the correct response" do
      response = described_class.get_statement(api_key, statement_id)
      expect(response).to eq({ "data" => "test_statement_data" })
    end
  end

  describe ".get_statement_attachments" do
    let(:statement_id) { 1 }
    let(:path) { "/statements/#{statement_id}/attachments/" }

    before do
      stub_request(:get, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_attachments" }.to_json)
    end

    it "sends a get request to the correct path with the correct parameters" do
      described_class.get_statement_attachments(api_key, statement_id)
      expect(WebMock).to have_requested(:get, "https://online.rospatent.gov.ru/external_api#{path}").once
    end

    it "returns the correct response" do
      response = described_class.get_statement_attachments(api_key, statement_id)
      expect(response).to eq({ "data" => "test_attachments" })
    end
  end

  describe ".get_statement_events" do
    let(:statement_id) { 1 }
    let(:path) { "/statements/#{statement_id}/events/" }

    before do
      stub_request(:get, "https://online.rospatent.gov.ru/external_api#{path}")
        .with(headers: { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" })
        .to_return(status: 200, body: { data: "test_events" }.to_json)
    end

    it "sends a get request to the correct path with the correct parameters" do
      described_class.get_statement_events(api_key, statement_id)
      expect(WebMock).to have_requested(:get, "https://online.rospatent.gov.ru/external_api#{path}").once
    end

    it "returns the correct response" do
      response = described_class.get_statement_events(api_key, statement_id)
      expect(response).to eq({ "data" => "test_events" })
    end
  end
end
