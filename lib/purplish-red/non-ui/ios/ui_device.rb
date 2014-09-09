class UIDevice
  def iphone5?
    UIScreen.mainScreen.bounds.size.height > 480
  end
end
