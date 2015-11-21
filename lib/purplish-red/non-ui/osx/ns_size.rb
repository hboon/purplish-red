class NSSize
  include CanScaleWidthHeight

  def self.to_native(anObject)
    anObject.to_size
  end

  def square?
    width == height && width > 0
  end
end
