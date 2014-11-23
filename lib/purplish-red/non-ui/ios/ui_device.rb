class UIDevice
  def iphone5?
    UIScreen.mainScreen.bounds.size.height > 480
  end

  def simulator?
    return UIDevice.currentDevice.name.include? 'Simulator'
  end
end
