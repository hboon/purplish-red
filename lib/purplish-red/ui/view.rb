module View
  def reload_constraints(&block)
    removeConstraints(constraints)
    block.call
    setNeedsUpdateConstraints(true)
  end

  #For debugging
  def hierarchy_description
    hierarchy = []
    v = self
    loop do
      hierarchy << v
      v = v.superview
      break if !v
    end
    hierarchy.collect {|e|e.to_s}.join(' - ')
  end

  def sv
    superview
  end

  def sv0; superview end
  def sv1; superview.superview end
  def sv2; superview.superview.superview end
  def sv3; superview.superview.superview.superview end
  def sv4; superview.superview.superview.superview.superview end

  def svs
    subviews
  end

  def svs0; subviews[0] end
  def svs1; subviews[1] end
  def svs2; subviews[2] end
  def svs3; subviews[3] end
  def svs4; subviews[4] end
end
