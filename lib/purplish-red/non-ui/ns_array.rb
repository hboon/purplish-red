class NSArray
  def to_rect
    CGRect.new([self[0][0], self[0][1]], [self[1][0], self[1][1]])
  end


  def to_size
    CGSize.new(self[0], self[1])
  end


  def to_set
    NSSet.setWithArray(self)
  end


  def to_index_path
    NSIndexPath.indexPathForRow(self[0], inSection:self[1])
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


class NSIndexPath
  def to_index_path
    self
  end
end
