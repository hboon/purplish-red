class Symbol
  def to_class
    NSClassFromString(self)
  end
end
