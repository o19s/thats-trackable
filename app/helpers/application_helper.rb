module ApplicationHelper

  def format_date(date)
#MM/DD/YYYY
    date.strftime("%m/%d/%Y") unless date.nil?
  end
end
