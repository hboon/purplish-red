class NSScreen
  def top
    frame.origin.y + frame.size.height
  end

  def bottom
    frame.origin.y
  end

  def left
    frame.origin.x
  end

  def right
    frame.origin.x + frame.size.width
  end

  def center
    NSMakePoint(left+width/2, top-height/2)
  end

  def center_x
    center.x
  end

  def center_y
    center.y
  end

  def width
    frame.size.width
  end

  def height
    frame.size.height
  end
end
