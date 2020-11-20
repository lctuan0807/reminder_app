module ApplicationHelper

  def date_parse_strftime(date)
    return unless date.present?
    date.strftime("%d-%m-%Y %H:%M:%S")
  end

  def boolean_humanize(boolean)
    boolean.to_s.humanize
  end
end
