require 'rails_helper'

RSpec.describe SmsCreator do
  let(:subject) { SmsCreator.new(user: user) }
  let(:user) { create(:user, phone: '+84377294383') }
  let(:sms) { ShortMessage.last }

  describe '#send_sms' do
    specify do
      expect{subject.send_sms}.to change(ShortMessage, :count).by(1)
      expect(sms.phone_number).to eq '+84377294383'
      expect(sms.content).to eq 'Sent from your Twilio trial account - Hello'
    end
  end
end
