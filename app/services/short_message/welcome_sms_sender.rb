class ShortMessage::WelcomeSmsSender
  def initialize(user_id:)
    @user_id = user_id
  end

  def perform
    success = short_message.save
    send_realtime_sms if success
    success
  end

  private

  def user
    @user ||= User.find(@user_id)
  end

  def sms_template_welcome
    ShortMessageTemplate.find_by(name: 'Welcome SMS template')
  end

  def short_message
    @short_message ||= ShortMessage.new(short_message_params)
  end

  def short_message_params
    {
      content: welcome_content,
      phone_number: user.phone,
      user_id: @user_id,
      expected_send_date: user.created_at,
      kind: ShortMessage.kinds[:realtime],
      status: ShortMessage.statuses[:unsent]
    }
  end

  def welcome_content
    sms_template_welcome.present? ? sms_template_welcome.content : "Welcome #{user.email} to Reminder App. Thanks!"
  end

  def send_realtime_sms
    ShortMessage::SmsSender.new(sms_id: short_message.id).perform
  end
end
