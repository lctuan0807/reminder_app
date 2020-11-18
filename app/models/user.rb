class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reminders
  has_many :short_messagess
  validates :email, :phone, presence: true

  after_save :create_reminder
  after_commit :create_short_messages, on: [:create]

  private

  def user
    User.find(id)
  end

  def create_reminder
    @reminder ||= ReminderCreator.new(user: user, params: reminder_params).perform
  end

  def reminder_params
    {
      title: 'Notify SMS after 7 days registration',
      due_date: user.created_at + 7.days
    }
  end

  def create_short_messages
    ShortMessage::SmsCreator.new(user: user, schedule: false).perform
    ShortMessage::SmsCreator.new(user: user, reminder: @reminder, schedule: true).perform
  end
end
