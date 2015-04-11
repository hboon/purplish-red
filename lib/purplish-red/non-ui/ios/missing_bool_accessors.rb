#We implement bool accessors in Cocoa (Touch) classes that define properties without getter=isXXX
class UIPushBehavior
  def active?
    active
  end
end
