class NSRange
  def to_index_set
    NSIndexSet.indexSetWithIndexesInRange(self)
  end
end
