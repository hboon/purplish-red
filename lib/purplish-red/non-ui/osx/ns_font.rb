class NSFont
  #Returns nil if not found
  def condensed(weight=0)
    NSFontManager.sharedFontManager.fontWithFamily(familyName, traits:NSCondensedFontMask, weight:weight, size:pointSize)
  end
end
