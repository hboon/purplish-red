module PurplishRed
  module Point
    module_function

    def zero
      if PurplishRed.ios?
        CGPointZero
      else
        NSZeroPoint 
      end
    end
  end
end

module Point
  def *(aNumber)
    self.class.new(x*aNumber, y*aNumber)
  end

  def /(aNumber)
    self.class.new(x/aNumber, y/aNumber)
  end
end
