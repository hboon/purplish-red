class NSString
  def to_img
    if PurplishRed.ios?
      UIImage.imageNamed(self)
    else
      NSImage.imageNamed(self)
    end
  end

  def to_imgt
    UIImage.imageNamed(self).imageWithRenderingMode(UIImageRenderingModeAlwaysTemplate)
  end

  def to_btn_template_rendering_mode(template_or_not)
    if template_or_not
      img = to_imgt
    else
      img = to_img
    end
    b = UIButton.buttonWithType(UIButtonTypeCustom)
    b.frame = [[0,0], [img.size.width, img.size.height]]
    b.setImage(img, forState:UIControlStateNormal)

    b
  end

  def to_btn
    to_btn_template_rendering_mode(false)
  end

  def to_btnt
    to_btn_template_rendering_mode(true)
  end

  def digits_only?
    split('').find {|e| e < '0' || e > '9'}.nil?
  end

  def to_url
    NSURL.URLWithString(self)
  end

  def escape_xml_entities
    if PR.osx?
      #CFXMLCreateStringByEscapingEntities is only available for OS X
      return CFXMLCreateStringByEscapingEntities(nil, self, nil)
    else
      s = self
      mapping = {'&' => "&amp;",
                 '"' => "&quot;",
                 '\'' => "&#39;",
                 '>' => "&gt;",
                 '<' => "&lt;"}
      mapping.each do |k, v|
        s = s.stringByReplacingOccurrencesOfString(k, withString:v)
      end
      s
    end
  end
end
