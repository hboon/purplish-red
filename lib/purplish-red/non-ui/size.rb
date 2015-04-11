module CanReturnSizeUsingLength
  def size
    length
  end
end

module CanReturnSizeUsingCount
  def size
    count
  end
end

class NSData
  include CanReturnSizeUsingLength
end

class NSHashTable
  include CanReturnSizeUsingCount
end

class NSMapTable
  include CanReturnSizeUsingCount
end

class NSOrderedSet
  include CanReturnSizeUsingCount
end

class NSPointerArray
  include CanReturnSizeUsingCount
end

class NSSet
  include CanReturnSizeUsingCount
end
