class ReminderCreator
  def initialize(user:)
    @user = user
  end

  def perform
    create_reminder_after_registration
    create_schedule_reminder
  end

  private

  def create_reminder_after_registration
    Reminder.new(title: 'Notify Message After Registration', user_id: @user.id).save
  end

  def create_schedule_reminder
    Reminder.new(title: 'Notify Message After 7 Days', schedule_date: schedule_date, user_id: @user.id).save
  end

  def schedule_date
    @user.created_at + 7.days
  end
end
