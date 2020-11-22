require 'rails_helper'

RSpec.describe ShortMessageWorker do
  describe '#perform' do
    Timecop.freeze(Time.zone.local(2020, 11, 20, 8, 0))
    let(:to_be_sent) { Time.zone.local(2020, 11, 15, 8, 0) }
    let(:do_not_send) { Time.zone.local(2020, 11, 30, 8, 3) }
    let(:mocked_sender) { double(ShortMessage::SmsSender) }


    let!(:short_message_1) { create(:short_message, status: ShortMessage.statuses[:unsent], 
      content: 'Send test sms 1', kind: ShortMessage.kinds[:realtime], expected_send_date: to_be_sent) }

    let!(:short_message_2) { create(:short_message, status: ShortMessage.statuses[:unsent], 
      content: 'Send test sms 2', kind: ShortMessage.kinds[:schedule], expected_send_date: to_be_sent) }

    let!(:short_message_3) { create(:short_message, status: ShortMessage.statuses[:unsent], 
      content: 'Send test sms 3', kind: ShortMessage.kinds[:schedule], expected_send_date: do_not_send) }

    let!(:short_message_4) { create(:short_message, status: ShortMessage.statuses[:unsent], 
      content: 'Send test sms 4', kind: ShortMessage.kinds[:realtime], expected_send_date: do_not_send) }

    let!(:short_message_5) { create(:short_message, status: ShortMessage.statuses[:sent], 
      content: 'Send test sms 5', kind: ShortMessage.kinds[:schedule], expected_send_date: do_not_send) }

    before do
      expect(ShortMessage::SmsSender).to receive(:new).with(sms_id: short_message_2.id).once.and_return(mocked_sender)
      expect(mocked_sender).to receive(:perform).and_return true
    end

    specify do 
      described_class.new.perform
    end
  end
end
