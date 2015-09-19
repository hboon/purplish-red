class NSData
  def to_unarchived_object
    NSKeyedUnarchiver.unarchiveObjectWithData(self)
  end
end
