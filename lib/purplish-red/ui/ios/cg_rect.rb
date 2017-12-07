class CGRect
  def inspect
    "#<#{self.class.name} [[#{origin.x}, #{origin.y}], [#{size.width}, #{size.height}]]>"
  end
end
