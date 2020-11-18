require 'rails_helper'

RSpec.describe ShortMessageWorker do
  let!(:short_message) { create(:short_message) }

  describe '#perform' do
    context 'sent success' do
    end

    context 'send failure' do
    end
  end
end
