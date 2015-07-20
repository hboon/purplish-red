class NSMenu
  def empty?
    numberOfItems == 0
  end

  def index_with_title(aString)
    (0...numberOfItems).detect {|i| itemAtIndex(i).title == aString}
  end

  def index_with_action(aStringOrSymbol)
    (0...numberOfItems).detect {|i| itemAtIndex(i).action == aStringOrSymbol.to_sym}
  end
end
