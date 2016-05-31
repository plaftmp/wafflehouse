require "seevibes/external_service/hubspot_dispatcher"

module ExternalService
  class HubspotDownloader
    def initialize(dispatcher:nil, logger:nil)
      @dispatcher = dispatcher
      @logger     = logger || respond_to?(:logger) ? logger : nil
    end

    def each_list(&block)
      return to_enum(:each_block) unless block

      raise "TODO: implement this method"
    end

    def each_email(id:, &block)
      return to_enum(:each_email) unless block

      logger && logger.info("Download Hubspot Contact List #{external_id.inspect}")

      offset = 0
      loop do
        logger && logger.debug{ "Requesting Hubspot Contact List #{external_id.inspect} starting at offset #{offset}" }
        response = dispatcher.dispatch(:get, "/contacts/v1/lists/#{external_id}/contacts/all?count=1000&vidOffset=#{offset}&property=email")

        response["contacts"].each do |contact|
          email = contact.fetch("properties", {}).fetch("email", {}).fetch("value", nil)
          yield email if email
        end

        break unless response["has-more"]
        offset += Integer(response["vid-offset"])
      end

      logger && logger.debug{ "Done downloading Hubspot Contact List #{external_id.inspect}" }
    end

    private

    attr_reader :refresh_token, :dispatcher
  end
end