class NSArray
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

class NSIndexPath
  def to_index_path
    self
  end
end
