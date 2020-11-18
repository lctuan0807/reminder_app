require 'rails_helper'

RSpec.describe ShortMessageTemplatesController, type: :controller do
  let(:user) { create(:user) }
  let!(:sms_template_1) { create(:short_message_template) }
  let!(:sms_template_2) { create(:short_message_template) }

  before { sign_in user }

  describe '#GET index' do
    specify do
      get :index
      expect(response).to have_http_status '200'
      expect(assigns(:short_message_templates)).to eq([sms_template_1,sms_template_2])
      expect(response).to render_template('index')
    end
  end

  describe '#GET new' do
    specify do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    specify do
      get :show, params: { id: sms_template_1 }
      expect(assigns(:short_message_template)).to eq(sms_template_1)
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    specify do
      get :edit, params: { id: sms_template_1 }
      expect(assigns(:short_message_template)).to eq(sms_template_1)
      expect(response).to render_template :edit
    end
  end
end
