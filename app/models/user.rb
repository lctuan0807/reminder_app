class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reminders
  has_many :short_messages
  validates :email, :phone, presence: true

  after_create :after_sign_up
  before_create :format_phone_number

  private

  def format_phone_number
    self.phone.slice! '0'
    self.phone = "+84#{self.phone}"
    self.phone
  end

  def after_sign_up
    send_welcome_sms
    create_schedule_sms
  end

  def send_welcome_sms
    ShortMessage::WelcomeSmsSender.new(user_id: id).perform
  end

  def create_schedule_sms
    ShortMessage::ScheduleSmsCreator.new(params: schedule_sms_params).perform
  end

  def schedule_sms_params
    {
      user_id: id,
      reminder_id: reminder&.id,
      expected_send_date: created_at + reminder.period_time
    }
  end

  def reminder
    @reminder ||= Reminder.find_by(title: 'Notify SMS after 7 days registration')
  end
end
