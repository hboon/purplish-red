module CanClearObject
  def clear
    removeAllObjects
    self
  end
end

class NSCache
  include CanClearObject
end

class NSHashTable
  include CanClearObject
end

class NSMapTable
  include CanClearObject
end

class NSMutableOrderedSet
  include CanClearObject
end

class NSMutableSet
  include CanClearObject
end
