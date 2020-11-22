class Reminder < ApplicationRecord
  belongs_to :sms_template, class_name: 'ShortMessageTemplate', foreign_key: 'sms_template_id'

  def period_time
    return 0 unless period_type.present?
    period.send("#{period_type}".pluralize) 
  end

  def period_time_text
    [period, period_type_humanize].join(' ')
  end

  def period_type_humanize
    period > 1 ? period_type.pluralize : period_type
  end
end
