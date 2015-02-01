class NSTimer
  def self.timer_after(seconds, &block)
    block.weak!
    NSTimer.scheduledTimerWithTimeInterval(seconds, target:self, selector:'timer_fired_with_block_as_user_info:', userInfo:block, repeats:false)
  end

  def self.timer_fired_with_block_as_user_info(aTimer)
    aTimer.userInfo.call
  end
end
