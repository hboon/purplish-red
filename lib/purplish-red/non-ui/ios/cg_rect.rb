class CGRect
  def scale(num)
    [[origin.x*num, origin.y*num], [size.width*num, size.height*num]].to_rect
  end

  def scale!(num)
    self.origin = [origin.x*num, origin.y*num]
    self.size = [size.width*num, size.height*num]
    self
  end

  def left
    origin.x
  end

  def left=(x)
    origin.x = x
  end

  def top
    origin.y
  end

  def top=(y)
    origin.y = y
  end

  def right
    origin.x+size.width
  end

  def right=(right)
    origin.x = right - size.width
  end

  def bottom
    origin.y+size.height
  end

  def bottom=(bottom)
    origin.y = bottom - size.height
  end

  def center_x
    left+size.width/2
  end

  def center_x=(center_x)
    self.left = center_x-size.width/2
  end

  def center_y
    top+size.height/2
  end

  def center_y=(center_y)
    self.top = center_y-size.height/2
  end

  def width
    size.width
  end

  def width=(w)
    size.width = w
  end

  def height
    size.height
  end

  def height=(h)
    size.height = h
  end
end
