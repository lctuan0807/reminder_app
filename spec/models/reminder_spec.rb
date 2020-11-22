require 'rails_helper'

RSpec.describe Reminder, type: :model do
  describe 'associations' do
    it { should belong_to(:sms_template).class_name('ShortMessageTemplate').with_foreign_key('sms_template_id') }
  end

  describe '#period_time' do
    let!(:reminder) { create(:reminder, period: 7, period_type: period_type) }

    context 'period type present' do
      let(:period_type) { 'hour' }

      it { expect(reminder.period_time).to eq(7.hours) }
    end

    context 'period type not present' do
      let(:period_type) { nil }

      it 'should return 0' do
        expect(reminder.period_time).to eq 0
      end
    end
  end

  describe '#period_time_text' do
    let!(:reminder) { create(:reminder, period: 7, period_type: 'hour') }

    it { expect(reminder.period_time_text).to eq '7 hours' }
  end

  describe '#period_type_humanize' do
    let!(:reminder) { create(:reminder, period: period, period_type: 'hour') }

    context 'period less equal 1' do
      let(:period) { 1 }

      it { expect(reminder.period_type_humanize).to eq 'hour' }
    end

    context 'period larger than 1' do
      let(:period) { 3 }

      it { expect(reminder.period_type_humanize).to eq 'hours' }
    end
  end
end
