#rubymotionbug - http://hipbyte.myjetbrains.com/youtrack/issue/RM-473
module CGPointExt
  def /(other)
    self.x /= other
    self.y /= other
    self
  end
end

CGPoint.send(:include, CGPointExt)
