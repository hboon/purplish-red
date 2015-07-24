class NSSet
  def to_a
    allObjects
  end

  def include?(anObject)
    containsObject(anObject)
  end
end
