module CanScaleWidthHeight
  def scale_to_fit(s)
    s = self.class.to_native(s)
    scaled = if s.width/s.height > width/height
               [s.height/height * width, s.height]
             else
               [s.width, s.width/width * height]
             end
    self.class.to_native(scaled)
  end

  def scale_to_fill(s)
    s = self.class.to_native(s)
    scaled = if s.width/s.height > width/height
               [s.width, s.width/width * height]
             else
               [s.height/height * width, s.height]
             end
    self.class.to_native(scaled)
  end

  def scale_to_fit!(s)
    s = self.class.to_native(s)
    if s.width/s.height > width/height
      self.width = s.height/height * width
      self.height = s.height
    else
      self.height = s.width/width * height
      self.width = s.width
    end
    self
  end

  def scale_to_fill!(s)
    s = self.class.to_native(s)
    if s.width/s.height > width/height
      self.width = s.width
      self.height = s.width/width * height
    else
      self.height = s.height
      self.width = s.height/height * width
    end
    self
  end
end
