class ViewWithBackgroundColor < NSView
  attr_accessor :background_color

  def drawRect(dirtyRect)
    return unless background_color
    background_color.set
    NSRectFill(bounds)
  end
end
