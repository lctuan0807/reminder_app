class SmsCreator
  attr_reader :client

  def initialize(user:, message:)
    @user = user
    @message = message
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  def send_sms
    message = @client.messages.create(
      from: phone_number,
      to: @user.phone,
      body: @message
    )
    ShortMessage.new(content: message.body, phone_number: message.to).save!
  end

  private

  def account_sid
    Rails.application.credentials.twilio[:account_sid]
  end

  def auth_token
    Rails.application.credentials.twilio[:auth_token]
  end

  def phone_number
    Rails.application.credentials.twilio[:phone_number]
  end
end
