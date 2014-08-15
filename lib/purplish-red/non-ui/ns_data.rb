class NSData
  def to_img
    UIImage.imageWithData(self)
  end

  def to_unarchived_object
    NSKeyedUnarchiver.unarchiveObjectWithData(self)
  end
end
