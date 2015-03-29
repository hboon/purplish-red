class Kernel
  def as(&block)
    block.call(self)
  end
end
