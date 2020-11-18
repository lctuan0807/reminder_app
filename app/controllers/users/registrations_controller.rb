class Users::RegistrationsController < Devise::RegistrationsController
  # after_action :create_short_message, only: [:create]

  private

  # def create_short_message
  #   resource.reminders.each do |reminder|
  #     schedule = reminder.due_date.present? ? true : false
  #     ShortMessage::SmsCreator.new(user: resource, reminder: reminder, schedule: schedule).perform
  #   end
  # end

  def sign_up_params
    params.require(:user).permit(:email, :password, :phone)
  end
end
