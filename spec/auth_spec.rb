require "rspec"
require "webmock/rspec"
require "json"
require_relative "../lib/rospatent/api_request_decorator.rb"

RSpec.describe Rospatent::Authorization do
  let(:path) { "/o/token/" }

  let(:client_id) { "id" }
  let(:client_secret) { "secret" }
  let(:redirect_uri) { "redirect_uri" }

  let(:mock_token) { "token" }
  let(:mock_refresh) { "refresh" }

  let(:mock_code) { "123" }

  before do
    Rospatent.configure do |c|
        c.client_id = client_id
        c.client_secret = client_secret
        c.redirect_uri = redirect_uri
    end
  end

  describe ".authorize_through_code" do
    before do
      stub_request(:post, "https://online.rospatent.gov.ru#{path}")
        .with(
            headers: { "Content-Type" => "application/x-www-form-urlencoded" },
            body: { "client_id" => client_id, "client_secret" => client_secret,
                    "grant_type" => "authorization_code", "redirect_uri" => redirect_uri,
                    "code": mock_code }
        )
        .to_return(status: 200, body: { access_token: mock_token, refresh_token: mock_refresh }.to_json)
    end

    it "returns the expected response" do
      response = described_class.authorize mock_code
      expect(response).to eq(described_class.new(mock_token, mock_refresh))
    end
  end
end
