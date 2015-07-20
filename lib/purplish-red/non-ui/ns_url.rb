class NSURL
  def to_url
    self
  end

  def to_url_request
    NSMutableURLRequest.requestWithURL(self)
  end
end
