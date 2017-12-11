class CGPoint
  def inspect
    "#<#{self.class.name} [#{x}, #{y}]>"
  end

  def translate(point)
    point = point.to_point
    CGPointMake(x + point.x, y + point.y)
  end

  def inside_rect?(rect)
    CGRectContainsPoint(rect, self)
  end
end
