class NSRange
  def to_index_set
    NSIndexSet.indexSetWithIndexesInRange(self)
  end

  def location_after
    location + length
  end
end
