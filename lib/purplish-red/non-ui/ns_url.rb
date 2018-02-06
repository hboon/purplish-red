class NSURL
  def to_url
    self
  end

  def to_url_request
    NSMutableURLRequest.requestWithURL(self)
  end

  def file_exists?
    NSFileManager.defaultManager.fileExistsAtPath(path)
  end

  def to_data
    NSData.dataWithContentsOfURL(self)
  end
end
