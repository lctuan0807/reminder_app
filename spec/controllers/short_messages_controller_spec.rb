require 'rails_helper'

RSpec.describe ShortMessagesController, type: :controller do
  let(:user) { create(:user) }
  let!(:short_message_1) { create(:short_message, content: 'SMS 1') }
  let!(:short_message_2) { create(:short_message) }

  before { sign_in user }

  describe '#GET index' do
    specify do
      get :index
      expect(response).to have_http_status '200'
      expect(assigns(:short_messages)).to eq([short_message_1,short_message_2])
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    specify do
      get :show, params: { id: short_message_1 }
      expect(assigns(:short_message)).to eq(short_message_1)
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    specify do
      get :edit, params: { id: short_message_1 }
      expect(assigns(:short_message)).to eq(short_message_1)
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    let(:params) do
      {
        id: short_message_1.to_param,
        short_message: {
          phone_number: phone_number,
          content: 'SMS content'
        }
      }
    end

    context 'success' do
      let(:phone_number) { '+84123456789' }

      specify do
        put :update, params: params
        expect(short_message_1.reload.phone_number).to eq '+84123456789'
        expect(short_message_1.reload.content).to eq 'SMS content'
        expect(response).to redirect_to short_messages_path
        expect(flash[:success]).to eq 'Update SMS successfully'
      end
    end

    context 'failure' do
      let(:phone_number) { '' }

      specify do
        put :update, params: params
        expect(short_message_1.reload.content).to eq 'SMS 1'
        expect(response).to render_template :edit
        expect(flash[:error]).to eq 'Update SMS failed'
      end
    end
  end
end
