require 'rails_helper'

RSpec.describe SmsClient do
  let(:subject) { described_class.new(from: from, to: to, body: body) }
  let(:client) { double(Twilio::REST::Client) }
  let(:mocked) do
    {
      account_sid: Rails.application.credentials.twilio[:account_sid],
      auth_token: Rails.application.credentials.twilio[:auth_token]
    }
  end
  let(:from) { '+1234567890' }
  let(:to) { '+84377913112' }
  let(:body) { 'Content' }
  
  before do
    allow(Twilio::REST::Client).to receive(:new).and_return client
    allow(client).to receive_message_chain('messages.create').with(from: from, to: to, body: body).and_return value
  end

  describe '#send_message' do
    context 'success' do
      let(:value) { true }

      specify do
        expect(subject.send_message).to be_truthy
      end
    end

    context 'failure' do
      let(:value) { false }

      specify do
        expect(subject.send_message).to be_falsey
      end
    end
  end
end
