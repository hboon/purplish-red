#We implement bool accessors in Cocoa (Touch) classes that define properties without getter=isXXX
class UIView
  def ambiguousLayout?
    hasAmbiguousLayout
  end
end
