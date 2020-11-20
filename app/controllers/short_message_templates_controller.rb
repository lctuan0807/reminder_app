class ShortMessageTemplatesController < ApplicationController
  before_action :short_message_template, only: [:show, :edit, :update, :destroy]

  def index
    @short_message_templates = ShortMessageTemplate.all
    render 'index'
  end

  def show
  end

  def edit
    render 'edit'
  end

  def update
    if @short_message_template.update(short_message_template_params)
      flash[:success] = 'Update SMS template successfully'
      redirect_to short_message_templates_path
    else
      flash[:error] = 'Update SMS template failed'
      render :edit
    end
  end

  private

  def short_message_template
    @short_message_template ||= ShortMessageTemplate.find(params[:id])
  end

  def short_message_template_params
    params.require(:short_message_template).permit(:name, :content, :enabled)
  end
end
