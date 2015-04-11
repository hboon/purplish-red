module CanDelete
  #Not 100% compatible with Ruby because we do not return the exact same object that was removed
  def delete(obj)
    removeObject(obj)
    obj
  end
end

class NSHashTable
  include CanDelete
end

class NSMutableOrderedSet
  include CanDelete
end

class NSMutableSet
  include CanDelete
end
