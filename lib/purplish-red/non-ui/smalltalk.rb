class Object
  def if_not_nil(&block)
    block.call(self)
  end

  def if_nil(&block)
    self
  end
end
class NilClass
  def if_not_nil(&block)
    self
  end

  def if_nil(&block)
    block.call
  end
end
