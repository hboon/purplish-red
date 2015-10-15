class NSData
  def to_unarchived_object
    NSKeyedUnarchiver.unarchiveObjectWithData(self)
  end

  def <<(aData)
    appendData(aData)
  end
end
