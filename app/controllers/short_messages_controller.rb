class ShortMessagesController < ApplicationController

  def create
    success = SmsCreator.new(user: current_user, params: short_message_params).create
    if success
      format.html { redirect_to @short_message, notice: 'Short message was successfully created.' }
    else
      redirect_to :new
    end
  end

  private

  def short_message_params
    require_params(:short_message)
  end
end
