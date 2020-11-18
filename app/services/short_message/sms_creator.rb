class ShortMessage::SmsCreator
  def initialize(user:, reminder: nil, schedule: false)
    @user = user
    @reminder = reminder
    @schedule = schedule
  end

  def perform
    success = short_message.save
    send_realtime_sms if success
  end

  private

  def short_message
    @short_message ||= ShortMessage.new(short_message_params)
  end

  def short_message_params
    {
      content: sms_content, 
      phone_number: @user.phone,
      user_id: @user.id,
      expected_send_date: expected_send_date,
      kind: sms_kind,
      status: ShortMessage.statuses[:unsent],
      reminder: @reminder
    }
  end

  def expected_send_date
    return unless @reminder.present?
    @reminder.due_date
  end

  def sms_kind
    @schedule ? ShortMessage.kinds[:schedule] : ShortMessage.kinds[:realtime]
  end

  def sms_content
    @schedule ? schedule_sms_content : realtime_sms_content
  end

  def realtime_sms_content
    "Welcome #{@user.email} to Reminder App. Thanks!"
  end

  def schedule_sms_content
    'You are about registration 7 days on our service'
  end

  def send_realtime_sms
    ShortMessageWorker.perform_async(short_message.id) if @short_message.kind == 'realtime'
  end
end
