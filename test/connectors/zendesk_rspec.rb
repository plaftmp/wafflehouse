require "connectors/zendesk"
require "hashie/mash"

RSpec.describe "connectors::CampaignMonitor"  do
  ENV["ZENDESK_API_TOKEN"] = "zendesk_api_token"
  let(:auth) do
    Hashie::Mash.new({
      credentials: {
        token: "zendesk_token",
        secret: "zendesk_secret"
      },
      extra: {
        raw_info: {
          url: 'zendesk_url',
          id: 'zendesk_id',
          name: 'zendesk_name',
          role: {name: 'zendesk_role_name'}
        }
      },
      info: {
        site: 'zendesk_site'
      }
    })
  end

  describe "connector" do
    it "Creates a zendesk connector" do
      connector = Connectors::Zendesk.new(nil, auth)

      expect(connector.connector_code).to match("zendesk")

      expect(connector.description).to match("zendesk_name")

      expect(connector.account_identifiers[:url]).to match("zendesk_url")
      expect(connector.account_identifiers[:id]).to match("zendesk_id")
      expect(connector.account_identifiers[:name]).to match("zendesk_name")
      expect(connector.account_identifiers[:role]).to match("zendesk_role_name")
      expect(connector.account_identifiers[:site]).to match("zendesk_site")


      expect(connector.credential_details[:api_token]).to match("zendesk_api_token")
      expect(connector.credential_details[:username]).to match("zendesk_token")
      expect(connector.credential_details[:secret]).to match("zendesk_secret")
    end
  end
end