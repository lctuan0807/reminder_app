require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.associations' do
    it { should have_many(:short_messages) }
  end

  describe '.validates' do
    let(:user) { create(:user) }

    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_presence_of(:phone) }
  end

  describe 'callback methods' do
    context 'after_create' do
      let(:sms_template) { create(:short_message_template, content: 'Hello') }
      let!(:reminder) { create(:reminder, title: 'Notify SMS after 7 days registration', sms_template_id: sms_template.id, due_after: 7) }
      let(:user) { build(:user_with_callback, email: 'test@hotmail.com') }

      specify do
        expect{ User.create(email: 'test@hotmail.com', phone: '+84378291827', password: '123123') }.to change(ShortMessage, :count).by(2)
        expect(ShortMessage.last.content).to eq 'Hello'
      end
    end 
  end
end
