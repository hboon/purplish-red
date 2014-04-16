#rubymotionbug – http://hipbyte.myjetbrains.com/youtrack/issue/RM-473
module CGPointExt
  def /(f)
    self.x /= f
    self.y /= f
    self
  end
end

CGPoint.send(:include, CGPointExt)
