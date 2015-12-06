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
