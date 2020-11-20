class ShortMessageWorker
  include Sidekiq::Worker
  
  def perform
    to_be_sent.find_each { |sms| ShortMessage::SmsSender.new(sms_id: sms.id).perform }
  end

  private

  def to_be_sent
    ShortMessage.scheduled.unsent.where('expected_send_date < ?', Time.zone.now)
  end
end
