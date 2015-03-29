class NSFont
  #Returns nil if not found
  def bold
    NSFontManager.sharedFontManager.fontWithFamily(familyName, traits:NSBoldFontMask, weight:0, size:pointSize)
  end
end
