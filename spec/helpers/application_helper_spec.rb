require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe '#date_parse_strftime' do
    let(:date) { Time.zone.local(2020, 11, 20, 2, 30, 40) }

    specify { expect(helper.date_parse_strftime(date)).to eq '20-11-2020 02:30:40' }
  end

  describe '#boolean_humanize' do
    let(:boolean) { true }
    specify { expect(helper.boolean_humanize(boolean)).to eq 'True' }
  end
end
