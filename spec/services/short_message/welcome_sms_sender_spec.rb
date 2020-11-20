require 'rails_helper'

RSpec.describe ShortMessage::WelcomeSmsSender do
  let(:subject) { described_class.new(user_id: user.id) }
  let!(:user) { create(:user, phone: '+84377134512', email: 'test@gmail.com') }
  let!(:short_message_template) { create(:short_message_template, name: 'Welcome SMS template',
    content: 'Welcome to our services, thanks so much!') }
  let(:sender) { double(ShortMessage::SmsSender) }

  describe '#perform' do
    context 'when save short_message success' do
      let(:short_message) { ShortMessage.last }
      before do
        expect(ShortMessage::SmsSender).to receive(:new).once.and_return sender
        expect(sender).to receive(:perform).and_return true
      end

      specify do
        expect{ expect(subject.perform).to be_truthy }.to change(ShortMessage, :count).by(1)
        expect(short_message.kind).to eq 'realtime'
        expect(short_message.content).to eq 'Welcome to our services, thanks so much!'
        expect(short_message.reload.status).to eq 'unsent'
      end
    end

    context 'when save short_message fail' do
      before do
        allow_any_instance_of(ShortMessage).to receive(:save).and_return false
        expect(ShortMessage::SmsSender).to_not receive(:new)
      end

      specify do
        expect{ expect(subject.perform).to be_falsey }.to change(ShortMessage, :count).by(0)
      end
    end
  end
end
