class Time
  def self.yesterday
    #60*60*24
    new - 86400
  end

  def self.today
    new
  end

  def date_only
    self.class.new(year, month, day)
  end
end
