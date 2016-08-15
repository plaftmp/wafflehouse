require "connectors/campaignmonitor"
require "hashie/mash"

RSpec.describe "Connectors::CampaignMonitor" do
  let(:auth) do
    Hashie::Mash.new({
      credentials: {
        expires_at: "a date",
        refresh_token: "campaignmonitor_refresh_token",
        token: "campaignmonitor_token",
      }
    })
  end

  describe "connector" do
    it "Creates a connector" do
      cs = Connectors::Createsend.new(nil, auth)

      expect(cs.connector_code).to match("createsend")

      expect(cs.description).to match("createsend mailinglist")

      expect(cs.credential_details[:expires]).to match('a date')
      expect(cs.credential_details[:refresh_token]).to match('campaignmonitor_refresh_token')
      expect(cs.credential_details[:oauth_token]).to match('campaignmonitor_token')
    end
  end
end