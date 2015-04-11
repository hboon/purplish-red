module CanScale
  def scale_to_fit(s)
    s = s.to_size
    if s.width/s.height > width/height
      [s.height/height * width, s.height]
    else
      [s.width, s.width/width * height]
    end
  end

  def scale_to_fill(s)
    s = s.to_size
    if s.width/s.height > width/height
      [s.width, s.width/width * height]
    else
      [s.height/height * width, s.height]
    end
  end
end
