class ShortMessagesController < ApplicationController
  before_action :short_message, only: [:show, :edit, :update, :destroy]

  def index
    @short_messages = ShortMessage.all
    render 'index'
  end

  def show
  end

  def edit
  end

  def new
    @short_message_templates = ShortMessageTemplate.enabled
  end

  def create
    if ShortMessage.new(short_message_params.merge!(user_id: current_user.id)).save
      flash[:success] = 'Create SMS successfully'
      redirect_to short_messages_path
    else
      flash[:error] = 'Create SMS failed'
      render :new
    end
  end

  def update
    if @short_message.update(short_message_params)
      flash[:success] = 'Update SMS successfully'
      redirect_to short_messages_path
    else
      flash[:error] = 'Update SMS failed'
      render :edit
    end
  end

  def destroy
    if @short_message.destroy
      flash[:success] = 'Delete SMS successfully'
      redirect_to short_messages_path
    else
      flash[:error] = 'Delete SMS failed'
    end
  end

  private

  def short_message
    @short_message ||= ShortMessage.find(params[:id])
  end

  def short_message_params
    params.require(:short_message).permit(:phone_number, :content, :expected_send_date, 
      :short_message_template_id, :status, :kind)
  end
end
