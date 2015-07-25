module CanReturnSizeUsingLength
  def size
    length
  end

  def empty?
    size == 0
  end
end

module CanReturnSizeUsingCount
  def size
    count
  end

  def empty?
    size == 0
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
