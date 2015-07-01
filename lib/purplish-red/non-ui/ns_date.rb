#Mostly copied from MOCommon

class NSDate
  ONE_MINUTE = 60
  ONE_HOUR = 60*60
  ONE_DAY = 60*60*24

  def self.from_day_month_year(d, m, y)
    dc = NSDateComponents.new
    dc.day = d
    dc.month = m
    dc.year = y
    NSCalendar.currentCalendar.dateFromComponents(dc)
  end

  def self.leap_year?(year)
    return false if year % 4 != 0
    return true if year % 100 != 0
    year % 400 == 0
  end

  #month is 1-12 representing Jan-Dec
  def self.days_in_month(month, year:year)
    case month
    when 1, 3, 5, 7, 8, 10, 12
      return 31
    when 4, 6, 9, 11
      return 30
    when 2
      return leap_year?(year)? 29: 28
    else
      #NSAssert(NO, @" Invalid month %d", month)
      return 0
    end
  end

  def yesterday_exactly
    dateByAddingTimeInterval(-60*60*24)
  end

  #0h, 0m, 0s
  def yesterday
    d_m_y = yesterday_exactly.day_month_year
    NSDate.from_day_month_year(d_m_y[0], d_m_y[1], d_m_y[2])
  end

  def day_month_year
    components = NSCalendar.currentCalendar.components(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit, fromDate:self)
    [components.day, components.month, components.year]
  end

  def hour_minute_second
    components = NSCalendar.currentCalendar.components(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit, fromDate:self)
    [components.hour, components.minute, components.second]
  end

  def year_month_day_s
    s = day_month_year
    format('%.4d%.2d%.2d', s[2], s[1], s[0])
  end

  def to_time
    components = NSCalendar.currentCalendar.components(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit, fromDate:self)
    Time.local(components.year, components.month, components.day, components.hour, components.minute, components.second)
  end
end
