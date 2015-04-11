class UIView
  def <<(v)
    addSubview(v)
    self
  end
end

class UIDynamicAnimator
  def <<(behavior)
    addBehavior(behavior)
    self
  end
end

class UIViewController
  def <<(obj)
    addChildViewController(obj)
    self
  end
end
