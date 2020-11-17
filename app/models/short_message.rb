class ShortMessage < ApplicationRecord
  belongs_to :user

  enum status: %i(sent unsent)
end