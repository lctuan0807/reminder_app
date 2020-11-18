class ReminderCreator
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def perform
    reminder.save
    @reminder
  end

  private

  def reminder
    @reminder ||= Reminder.new(title: @params[:title], due_date: @params[:due_date], user_id: @user_id)
  end
end
