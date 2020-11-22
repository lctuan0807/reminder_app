class ShortMessage::ScheduleSmsCreator
  def initialize(params:)
    @params = params
  end

  def perform
    short_message.save
  end

  private

  def user
    User.find(@params[:user_id])
  end

  def reminder
    Reminder.find(@params[:reminder_id])
  end

  def sms_template
    reminder.sms_template if reminder.present?
  end

  def short_message
    @short_message ||= ShortMessage.new(@params.merge!(schedule_sms_params))
  end

  def schedule_sms_params
    {
      phone_number: user.phone,
      expected_send_date: @params[:expected_send_date],
      kind: ShortMessage.kinds[:schedule],
      status: ShortMessage.statuses[:unsent],
      content: sms_content
    }
  end

  def sms_content
    sms_template.present? ? sms_template.content : @params[:content]
  end
end
