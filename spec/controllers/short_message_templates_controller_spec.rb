require 'rails_helper'

RSpec.describe ShortMessageTemplatesController, type: :controller do
  let(:user) { create(:user) }
  let!(:sms_template_1) { create(:short_message_template, name: 'SMS template 1') }
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

  describe 'GET #edit' do
    specify do
      get :edit, params: { id: sms_template_1 }
      expect(assigns(:short_message_template)).to eq(sms_template_1)
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    let(:params) do
      {
        id: sms_template_1.to_param,
        short_message_template: {
          name: name,
          content: 'SMS template content'
        }
      }
    end

    context 'success' do
      let(:name) { 'sms template' }

      specify do
        put :update, params: params
        expect(sms_template_1.reload.name).to eq 'sms template'
        expect(sms_template_1.reload.content).to eq 'SMS template content'
        expect(response).to redirect_to short_message_templates_path
        expect(flash[:success]).to eq 'Update SMS template successfully'
      end
    end

    context 'failure' do
      let(:name) { '' }

      specify do
        put :update, params: params
        expect(sms_template_1.reload.name).to eq 'SMS template 1'
        expect(response).to render_template :edit
        expect(flash[:error]).to eq 'Update SMS template failed'
      end
    end
  end
end
