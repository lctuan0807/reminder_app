class Reminder < ApplicationRecord
  belongs_to :user
  has_many :short_message
end
