require "connectors/createsend"
require "hashie/mash"

RSpec.describe "Connectors::Creatsend" do
  let(:auth) do
    Hashie::Mash.new({
      "credentials" => {
        "expires_at" => "a date",
        "refresh_token" => "createsend_refresh_token",
        "token" => "createsend_token",
      }
    })
  end

  describe "connector" do
    it "creates a connector" do
      cs = Connectors::Createsend.new(nil, auth);
      expect(cs.connector_code).to match("createsend")
      expect(cs.description).to match("createsend mailinglist")
      expect(cs.credential_details[:expires]).to match('a date')
      expect(cs.credential_details[:refresh_token]).to match('createsend_refresh_token')
      expect(cs.credential_details[:oauth_token]).to match('createsend_token')
    end
  end
end