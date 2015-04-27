class ViewWithBackgroundColor < NSView
  attr_accessor :background_color, :background_radius

  def drawRect(dirtyRect)
    return unless background_color
    background_color.set
    if background_radius && background_radius > 0
      path = NSBezierPath.bezierPathWithRoundedRect(frame, xRadius:background_radius, yRadius:background_radius)
      path.fill
    else
      NSRectFill(bounds)
    end
  end
end
