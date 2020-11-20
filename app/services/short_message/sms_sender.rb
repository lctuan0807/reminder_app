class ShortMessage::SmsSender
  def initialize(sms_id:)
    @sms_id = sms_id
  end

  def perform
    short_message
    success = client.send_message
    update_short_message(success, short_message)
  end

  private

  def short_message
    @short_message ||= ShortMessage.find(@sms_id)
  end

  def update_short_message(success, short_message)
    if success
      short_message.status = ShortMessage.statuses[:sent]
    else
      short_message.status = ShortMessage.statuses[:failed]
    end
    short_message.save
  end

  def client
    @client ||= SmsClient.new(to: short_message.phone_number, body: short_message.content)
  end
end
