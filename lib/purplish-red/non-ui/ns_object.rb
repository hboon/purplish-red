class NSObject
  def to_archive_data
    NSKeyedArchiver.archivedDataWithRootObject(self)
  end
end
