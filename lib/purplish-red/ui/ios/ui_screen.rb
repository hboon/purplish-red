class UIScreen
  def top
    bounds.origin.y
  end

  def bottom
    bounds.origin.y + bounds.size.height
  end

  def left
    bounds.origin.x
  end

  def right
    bounds.origin.x + bounds.size.width
  end

  def center
    CGPointMake(left+width/2, top-height/2)
  end

  def center_x
    bounds.origin.x + bounds.size.width/2
  end

  def center_y
    bounds.origin.y + bounds.size.height/2
  end

  def width
    bounds.size.width
  end

  def height
    bounds.size.height
  end
end
