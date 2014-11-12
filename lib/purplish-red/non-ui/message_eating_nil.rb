class MessageEatingNil
  def self.log_method_missing=(aBool)
    @log_method_missing = aBool
  end

  def self.log_method_missing?
    !!@log_method_missing
  end

  #Block with args (method_name, *args)
  def self.on_method_missing(&block)
    self.log_method_missing = true
    @method_missing_block = block
  end

  def self.method_missing_block
    @method_missing_block
  end

  def method_missing(m, *args, &block)
    if self.class.log_method_missing?
      self.class.method_missing_block.call(m, *args)
    end
  end
end
