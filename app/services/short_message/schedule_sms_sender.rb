class ShortMessage::ScheduleSmsSender
  class << self
    def perform
      to_be_sent.find_each { |sms| ShortMessageWorker.new.perform(sms.id) }
    end

    private

    def to_be_sent
      ShortMessage.scheduled.schedule.unsent.where('expected_send_date < ?', Time.zone.now)
    end
  end
end
