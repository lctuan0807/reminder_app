require 'rails_helper'

RSpec.describe ShortMessageTemplate, type: :model do
  describe '.validates' do
    let(:short_message_template) { create(:short_message_template) }

    it { expect(short_message_template).to validate_presence_of(:name) }
  end

  describe '.scope' do
    let(:short_message_template_1) { create(:short_message_template) }
    let(:short_message_template_2) { create(:short_message_template, enabled: false) }

    specify do
      expect(ShortMessageTemplate.enabled).to include(short_message_template_1)
    end
  end
end
