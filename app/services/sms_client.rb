class SmsClient
  attr_accessor :client

  def initialize(from: Rails.application.credentials.twilio[:phone_number], to:, body:)
    @client = Twilio::REST::Client.new
    @to = to
    @body = body
    @from = from
  end

  def send_message
    begin
      return true if @client.messages.create(from: @from, to: @to, body: @body)
    rescue Twilio::REST::RestError => e
      e.message
      false
    end
  end
end