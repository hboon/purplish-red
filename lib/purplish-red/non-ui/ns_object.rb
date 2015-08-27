class NSObject
  def self.unarchive_from(aPath)
    NSKeyedUnarchiver.unarchiveObjectWithFile(aPath)
  end

  def to_archive_data
    NSKeyedArchiver.archivedDataWithRootObject(self)
  end

  def archive_to(aPath)
    NSKeyedArchiver.archiveRootObject(self, toFile:aPath)
  end
end
