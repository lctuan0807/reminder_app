require 'rails_helper'

RSpec.describe ShortMessage, type: :model  do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:reminder) }
  end

  describe '.scope' do
    let(:short_message_1) { create(:short_message, content: 'content 1', phone_number: '0101010101', kind: ShortMessage.kinds[:schedule]) }
    let(:short_message_2) { create(:short_message, content: 'content 2', phone_number: '0202020202', kind: ShortMessage.kinds[:realtime]) }

    specify do
      expect(ShortMessage.scheduled).to include(short_message_1)
    end
  end

  describe '.validates' do
    let(:short_message) { create(:short_message) }

    it { expect(short_message).to validate_presence_of(:phone_number) }
    it { expect(short_message).to validate_presence_of(:content) }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values([:unsent, :sent, :failed]) }
    it { should define_enum_for(:kind).with_values([:realtime, :schedule]) }
  end
end
