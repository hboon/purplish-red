module PurplishRed
  module Rect
    module_function

    def zero
      if PurplishRed.ios?
        CGRectZero
      else
        NSZeroRect
      end
    end
  end
end
