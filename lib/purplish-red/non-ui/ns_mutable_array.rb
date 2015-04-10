class NSArray
  def to_set
    NSMutableSet.setWithArray(self)
  end
end
