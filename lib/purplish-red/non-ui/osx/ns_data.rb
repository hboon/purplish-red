class NSData
  def to_img
    NSImage.alloc.initWithData(self)
  end
end
