require 'rails_helper'

RSpec.describe RemindersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:reminder_1) { create(:reminder, title: 'Reminder 1') }
  let!(:reminder_2) { create(:reminder) }

  before { sign_in user }

  describe '#GET index' do
    specify do
      get :index
      expect(response).to have_http_status '200'
      expect(assigns(:reminders)).to eq([reminder_1, reminder_2])
      expect(response).to render_template('index')
    end
  end

  describe 'GET #edit' do
    specify do
      get :edit, params: { id: reminder_1 }
      expect(assigns(:reminder)).to eq(reminder_1)
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    let(:params) do
      {
        id: reminder_1.to_param,
        reminder: {
          title: 'reminder',
          period: 7,
          period_type: 'hour'
        }
      }
    end

    context 'success' do
      specify do
        put :update, params: params
        expect(reminder_1.reload.title).to eq 'reminder'
        expect(reminder_1.reload.period).to eq 7
        expect(response).to redirect_to reminders_path
        expect(flash[:success]).to eq 'Update reminder successfully'
      end
    end

    context 'failure' do
      before { allow_any_instance_of(Reminder).to receive(:update).and_return false }

      specify do
        put :update, params: params
        expect(reminder_1.reload.title).to eq 'Reminder 1'
        expect(response).to render_template :edit
        expect(flash[:error]).to eq 'Update reminder failed'
      end
    end
  end
end
