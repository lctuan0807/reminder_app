require 'rails_helper'

RSpec.describe ShortMessage::SmsCreator do
  let(:subject) { described_class.new(user: user, reminder: reminder, schedule: schedule) }
  let(:user) { create(:user, phone: '+84377134512') }

  describe '#perform' do
    let(:short_message) { ShortMessage.last }

    context 'realtime sms' do
      let(:reminder) { create(:reminder, title: 'Notified Message After Registration', due_date: nil, user_id: user.id) }
      let(:schedule) { false }

      specify do
        expect{ expect(subject.perform).to be_truthy }.to change(ShortMessage, :count).by(1)
          .and change(ShortMessageWorker.jobs, :size).by(1)
        expect(short_message.kind).to eq 'realtime'
        expect(short_message.content).to eq 'Welcome to Reminder App. Thanks!'
        expect(short_message.status).to eq 'sent'
      end
    end

    context 'schedule sms' do
      let(:reminder) { create(:reminder, title: 'Notified Message After 7 Days', due_date: Time.zone.local(2020,11,30), user_id: user.id) }
      let(:schedule) { true }

      specify do
        expect{ expect(subject.perform).to be_truthy }.to change(ShortMessage, :count).by(1)
        expect(short_message.kind).to eq 'schedule'
        expect(short_message.content).to eq 'You are about registration 7 days on our service'
        expect(short_message.status).to eq 'unsent'
        expect(short_message.expected_send_date).to eq Time.zone.local(2020,11,30)
      end
    end
  end
end
