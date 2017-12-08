class CGRect
  def inspect
    "#<#{self.class.name} [[#{origin.x}, #{origin.y}], [#{size.width}, #{size.height}]]>"
  end

  def translate(point)
    pt = origin.translate(point)
    CGRectMake(pt.x, pt.y, size.width, size.height)
  end

  def center
    CGPointMake(CGRectGetMidX(self), CGRectGetMidY(self))
  end
end
