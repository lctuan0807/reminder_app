require 'rails_helper'

RSpec.describe Reminder, type: :model do
  describe 'associations' do
    it { should belong_to(:sms_template).class_name('ShortMessageTemplate').with_foreign_key('sms_template_id') }
  end
end
