class NSSize
  include CanScaleWidthHeight

  def self.to_native(anObject)
    anObject.to_size
  end
end
