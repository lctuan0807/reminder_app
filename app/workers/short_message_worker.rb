class ShortMessageWorker
  include Sidekiq::Worker

  def perform(message_id)
    short_message = ShortMessage.find(message_id)
    send_sms(short_message)
    update_short_message(short_message)
  end

  private

  def send_sms(short_message)
    begin
      client.messages.create(from: Rails.application.credentials.twilio[:phone_number],
                            to: short_message.phone_number,
                            body: short_message.content)
      true
    rescue Twilio::REST::RestError => e
      e.message
      false
    end
  end

  def update_short_message(short_message)
    if send_sms(short_message)
      short_message.status = ShortMessage.statuses[:sent]
    else
      short_message.status = ShortMessage.statuses[:failed]
    end
    short_message.save
  end

  def client
    @client ||= Twilio::REST::Client.new
  end
end
