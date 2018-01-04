class CGRect
  def inspect
    "#<#{self.class.name} [[#{origin.x}, #{origin.y}], [#{size.width}, #{size.height}]]>"
  end

  def translate(point)
    pt = origin.translate(point.to_point)
    CGRectMake(pt.x, pt.y, size.width, size.height)
  end

  def center
    CGPointMake(CGRectGetMidX(self), CGRectGetMidY(self))
  end

  def contains?(rect_or_point)
    rect_or_point.inside_rect? self
  end

  def inside_rect?(rect)
    CGRectContainsRect(rect, self)
  end

  def inset(x, y=x)
    CGRectInset(self, x, y)
  end

  def intersects?(rect)
    CGRectIntersectsRect(self, rect)
  end
end
