class NSData
  include CanReturnSizeUsingLength

  def to_img
    UIImage.imageWithData(self)
  end
end
