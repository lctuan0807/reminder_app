class Reminder < ApplicationRecord
  belongs_to :sms_template, class_name: 'ShortMessageTemplate', foreign_key: 'sms_template_id'
end
