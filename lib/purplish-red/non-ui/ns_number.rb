class NSNumber
  def from_deg_to_rad
    self * Math::PI/180
  end

  def from_rad_to_deg
    self * 180/Math::PI
  end

  def to_index_set
    NSIndexSet.indexSetWithIndex(self)
  end
end
