#Stuff I copied from MOCommon (from UIView)
module View
  def left
    frame.origin.x
  end

  def left=(x)
    f = frame
    f.origin.x = x
    self.frame = f
  end

  def right
    frame.origin.x + frame.size.width
  end

  def right=(right)
    f = frame
    f.origin.x = right - f.size.width
    self.frame = f
  end

  def center_x
    center.x
  end

  def center_x=(center_x)
    self.center = [center_x, center.y]
  end

  def center_y
    center.y
  end

  def center_y=(center_y)
    self.center = [center.x, center_y]
  end

  def width
    frame.size.width
  end

  def width=(width)
    f = frame
    f.size.width = width
    self.frame = f
  end

  def height
    frame.size.height
  end

  def size_width_to_fit
    h = height
    sizeToFit
    self.height = h
  end

  def size_width_to_fit_align_right
    x = right
    size_width_to_fit
    self.right = x
  end

  def size_width_to_fit_max(f)
    size_width_to_fit
    self.width = f if width > f
  end

  def size_width_to_fit_min(f)
    size_width_to_fit
    self.width = f if width < f
  end

  def size_height_to_fit
    w = width
    #Otherwise it doesn't expand short UILabel when it's too short to fit longer text
    self.height = 1000
    sizeToFit
    self.width = w
  end

  def size_height_to_fit_align_bottom
    y = bottom
    size_height_to_fit
    self.bottom = y
  end

  def size_height_to_fit_max(f)
    size_height_to_fit
    self.height = f if height > f
  end

  def size_height_to_fit_min(f)
    size_height_to_fit
    self.height = f if height < f
  end

  #For debugging
  def hierarchy_description
    hierarchy = []
    v = self
    loop do
      hierarchy << v
      v = v.superview
      break if !v
    end
    hierarchy.collect {|e|e.to_s}.join(' - ')
  end

  def sv
    superview
  end

  def sv0; superview end
  def sv1; superview.superview end
  def sv2; superview.superview.superview end
  def sv3; superview.superview.superview.superview end
  def sv4; superview.superview.superview.superview.superview end

  def svs
    subviews
  end

  def svs0; subviews[0] end
  def svs1; subviews[1] end
  def svs2; subviews[2] end
  def svs3; subviews[3] end
  def svs4; subviews[4] end
end