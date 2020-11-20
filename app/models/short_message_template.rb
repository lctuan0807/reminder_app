class ShortMessageTemplate < ApplicationRecord
  validates :name, presence: true

  scope :enabled, -> { where(enabled: true) }
end
