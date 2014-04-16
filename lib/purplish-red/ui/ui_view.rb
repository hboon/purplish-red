#Stuff I copied from MOCommon
class UIView
  def left
    frame.origin.x
  end


  def left=(x)
    f = frame
    f.origin.x = x
    self.frame = f
  end

  def top
    frame.origin.y
  end


  def top=(y)
    f = frame
    f.origin.y = y
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

  def bottom
    frame.origin.y + frame.size.height
  end


  def bottom=(bottom)
    f = frame
    f.origin.y = bottom - f.size.height
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


  def height=(height)
    f = frame
    f.size.height = height
    self.frame = f
  end


  def size_width_to_fit
    h = height
    sizeToFit
    self.height = h
  end


  def size_height_to_fit
    w = width
    #Otherwise it doesn't expand short UILabel when it's too short to fit longer text
    self.height = 1000
    sizeToFit
    self.width = w
  end


  def size_width_to_fit_align_right
    x = right
    size_width_to_fit
    self.right = x
  end


  def size_height_to_fit_align_bottom
    y = bottom
    size_height_to_fit
    self.bottom = y
  end


  def size_width_to_fit_max(f)
    size_width_to_fit

    if width > f
      self.width = f
    end
  end


  def size_width_to_fit_min(f)
    size_width_to_fit

    if width < f
      self.width = f
    end
  end


  def size_height_to_fit_max(f)
    size_height_to_fit

    if height > f
      self.height = f
    end
  end


  def size_height_to_fit_min(f)
    size_height_to_fit

    if height < f
      self.height = f
    end
  end


  def origin_relative_to_superview(v)
    sup = superview
    offset = CGPointZero

    #if ([sup isKindOfClass:[UIScrollView class]]) {
      #offset = ((UIScrollView*)sup).contentOffset
    #}

    if !sup || v == sup
      return CGPoint.new(left-offset.x, top-offset.y)
    else
      d = sup.origin_relative_to_superview(v)
      return CGPoint.new(left+d.x-offset.x, top+d.y-offset.y)
    end
  end


  def move_origin_relative_to_superview(v)
    pt = origin_relative_to_superview(v)
    self.left = pt.x
    self.top = pt.y
  end


  def <<(v)
    addSubview(v)
    self
  end
end
