class NSNumber
  def from_deg_to_rad
    self * Math::PI/180
  end

  def from_rad_to_deg
    self * 180/Math::PI
  end
end
