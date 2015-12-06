class UIView
  def bring_to_front
    superview.bringSubviewToFront(self)
  end

  def send_to_back
    superview.sendSubviewToBack(self)
  end
end
