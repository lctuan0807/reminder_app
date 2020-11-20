require 'rails_helper'

RSpec.describe ShortMessage::SmsSender do
  let(:subject) { described_class.new(sms_id: short_message.id) }
  let!(:short_message) { create(:short_message, status: ShortMessage.statuses[:unsent], content: 'Send test sms', phone_number: phone_number) }
  let(:mocked_client) { double(SmsClient) }

  describe '#perform' do
    before do
      expect(SmsClient).to receive(:new).and_return mocked_client
      expect(mocked_client).to receive(:send_message).and_return value
    end

    context 'send success' do
      let(:phone_number) { '+84377294383' }
      let(:value) { true }

      specify do
        subject.perform
        expect(short_message.reload.status).to eq 'sent'
      end
    end

    context 'send failure' do
      let(:phone_number) { '03' }
      let(:value) { false }

      specify do
        subject.perform
        expect(short_message.reload.status).to eq 'failed'
      end
    end
  end
end
