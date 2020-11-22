require 'rails_helper'

RSpec.describe ShortMessage::ScheduleSmsCreator do
  let(:subject) { described_class.new(params: params) }
  let!(:user) { create(:user, phone: '+84377134512', email: 'test@gmail.com', created_at: Time.zone.local(2020,11,23)) }
  let!(:sms_template) { create(:short_message_template, id: 2, content: 'Hello') }
  let!(:reminder) { create(:reminder, sms_template_id: sms_template.id, period: 7) }

  describe '#perform' do
    let(:params) do
      {
        reminder_id: reminder.to_param,
        user_id: user.to_param,
        expected_send_date: user.created_at + reminder.period_time
      }
    end
    let(:short_message) { ShortMessage.last }
    
    context 'when save success' do
      let(:phone_number) { user.phone }

      specify do
        expect{ subject.perform }.to change(ShortMessage, :count).by(1)
        expect(short_message.kind).to eq 'schedule'
        expect(short_message.content).to eq 'Hello'
        expect(short_message.status).to eq 'unsent'
        expect(short_message.expected_send_date).to eq Time.zone.local(2020,11,30)
      end
    end

    context 'when save failed' do
      before { allow_any_instance_of(ShortMessage).to receive(:save).and_return false }

      specify { expect{ subject.perform }.to_not change(ShortMessage, :count) }
    end
  end
end
