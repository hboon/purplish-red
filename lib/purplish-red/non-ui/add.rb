module CanAddObject
  def <<(obj)
    addObject(obj)
    self
  end
end

class NSMutableSet 
  include CanAddObject
end

class NSAutoreleasePool 
  include CanAddObject
end

class NSHashTable 
  include CanAddObject
end

class NSMutableOrderedSet 
  include CanAddObject
end

class NSMutableIndexSet
  def <<(obj)
    addIndex(obj)
    self
  end
end

class AVAssetWriter
  def <<(obj)
    addInput(obj)
    self
  end
end

class AVAssetReader
  def <<(obj)
    addOutput(obj)
    self
  end
end

class AVPlayerItem
  def <<(obj)
    addOutput(obj)
    self
  end
end

class NSPointerArray
  def <<(obj)
    addPointer(obj)
    self
  end
end

class CALayer
  def <<(obj)
    addSublayer(obj)
    self
  end
end

class NSOperationQueue
  def <<(obj)
    addOperation(obj)
    self
  end
end

class NSFileWrapper
  def <<(obj)
    addFileWrapper(obj)
    self
  end
end
