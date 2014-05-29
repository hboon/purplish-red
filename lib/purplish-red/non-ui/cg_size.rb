class CGSize
  def scale_to_fit(aSize)
    aSize = aSize.to_size
    if aSize.width/aSize.height > width/height
      [aSize.height/height * width, aSize.height]
    else
      [aSize.width, aSize.width/width * height]
    end
  end


  def scale_to_fill(aSize)
    aSize = aSize.to_size
    if aSize.width/aSize.height > width/height
      [aSize.width, aSize.width/width * height]
    else
      [aSize.height/height * width, aSize.height]
    end
  end
end
