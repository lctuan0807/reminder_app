class ShortMessageTemplatesController < ApplicationController
  def index
    @short_message_templates = ShortMessageTemplate.all
    render 'index'
  end

  def new
    render 'new'
  end

  def edit
    render 'edit'
  end

  def create
    if short_message_template.save
      flash[:success] = 'Create SMS template successfully'
      redirect_to short_message_templates
    else
      flash[:failure] = 'Create SMS template failed'
      render :new
    end
  end

  def update
    short_message_template = ShortMessageTemplate.find(params[:id])

    if short_message_template.update!(short_message_template_params)
      flash[:success] = 'Update SMS template successfully'
      redirect_to short_message_templates
    else
      flash[:failure] = 'Update SMS template failed'
      render :edit
    end
  end

  def destroy
  end

  private

  def short_message_template
    @short_message_template ||= ShortMessageTemplate.new(short_message_template_params)
  end

  def short_message_template_params
    params.require(:short_message_templates).permit(:name, :content, :enabled)
  end
end
