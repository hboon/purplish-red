class NSArray
  def to_rect
    CGRect.new([self[0][0], self[0][1]], [self[1][0], self[1][1]])
  end
end


#Can't put this into a cg_rect.rb. No idea why
class CGRect
  def to_rect
    self
  end


  def scale(num)
    [[origin.x*num, origin.y*num], [size.width*num, size.height*num]].to_rect
  end


  def scale!(num)
    self.origin = [origin.x*num, origin.y*num]
    self.size = [size.width*num, size.height*num]
    self
  end
end

