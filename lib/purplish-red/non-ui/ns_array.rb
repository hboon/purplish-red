class NSArray
  def to_rect
    if PurplishRed.ios?
      CGRect.new([self[0][0], self[0][1]], [self[1][0], self[1][1]])
    else
      NSRect.new([self[0][0], self[0][1]], [self[1][0], self[1][1]])
    end
  end

  def to_size
    if PurplishRed.ios?
      CGSize.new(self[0], self[1])
    else
      NSSize.new(self[0], self[1])
    end
  end

  def to_point
    if PurplishRed.ios?
      CGPoint.new(self[0], self[1])
    else
      NSPoint.new(self[0], self[1])
    end
  end

  def to_set
    NSSet.setWithArray(self)
  end

  def to_index_path
    NSIndexPath.indexPathForRow(self[0], inSection:self[1])
  end

  def to_range
    NSMakeRange(self[0], self[1])
  end
end

class CGRect
  def to_rect
    self
  end
end

class CGSize
  def to_size
    self
  end
end

class CGPoint
  def to_point
    self
  end
end

class NSRect
  def to_rect
    self
  end
end

class NSSize
  def to_size
    self
  end
end

class NSPoint
  def to_point
    self
  end
end

class NSIndexPath
  def to_index_path
    self
  end
end
