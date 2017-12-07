class CGPoint
  def inspect
    "#<#{self.class.name} [#{x}, #{y}]>"
  end

  def translate(point)
    CGPointMake(x + point.x, y + point.y)
  end
end
