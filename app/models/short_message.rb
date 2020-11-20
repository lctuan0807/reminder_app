class ShortMessage < ApplicationRecord
  belongs_to :user
  belongs_to :reminder

  enum status: [:unsent, :sent, :failed]
  enum kind: [:realtime, :schedule]

  validates :phone_number, :content, presence: true

  scope :scheduled, -> { where(kind: 'schedule') }
end
