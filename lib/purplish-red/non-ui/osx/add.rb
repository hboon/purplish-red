class NSArrayController
  include CanAddObject
end

class NSView
  def <<(v)
    addSubview(v)
    self
  end
end
