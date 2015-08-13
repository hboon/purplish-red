class NSSegmentedControl
  def segment_images=(anArray)
    self.segmentCount = anArray.size
    anArray.each_with_index do |e, i|
      setImage(e, forSegment:i)
      cell.setTag(i, forSegment:i)
    end
  end

  def segment_tooltips=(anArray)
    self.segmentCount = anArray.size
    anArray.each_with_index do |e, i|
      cell.setToolTip(e, forSegment:i)
    end
  end

  def segment_labels=(anArray)
    self.segmentCount = anArray.size
    anArray.each_with_index do |e, i|
      setLabel(e, forSegment:i)
    end
  end
end
