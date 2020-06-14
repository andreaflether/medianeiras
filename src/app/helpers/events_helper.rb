module EventsHelper
  def complete_date(start_date)
    l(start_date, format: "%A, %-d de %B de %Y")
  end 

  def event_time(start_hour, end_hour)
    ends_at = end_hour.to_s(:time)
    l(start_hour, format: "%H:%M às #{ends_at}")
  end

  def date_format(date)
    date.nil? ? "" : date.strftime("%d/%m/%Y %H:%M")
  end 

  def event_date(start_date)
    l(start_date, format: "%-d de %B de %Y")
  end 

  def event_time_format(starts_at, ends_at, type)
    start = starts_at.to_s(:time)
    ending = ends_at.to_s(:time)
    week_day = l(starts_at, format: "%A")
    case type 
    when 'start_end'
      "#{start} às #{ending}"
    when 'week_day_time'
      "#{week_day} - #{start} às #{ending}"
    end 
  end  
end
