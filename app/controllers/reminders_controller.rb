class RemindersController < ApplicationController
  before_action :reminder, only: [:show, :edit, :update, :destroy]

  def index
    @reminders = Reminder.all
    render 'index'
  end

  def show
  end

  def edit
    render 'edit'
  end

  def update
    if @reminder.update(reminder_params)
      flash[:success] = 'Update reminder successfully'
      redirect_to reminders_path
    else
      flash[:error] = 'Update reminder failed'
      render :edit
    end
  end

  private

  def reminder
    @reminder ||= Reminder.find(params[:id])
  end

  def reminder_params
    params.require(:reminder).permit(:title, :period, :period_type)
  end
end
