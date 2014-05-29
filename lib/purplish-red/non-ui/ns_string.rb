class NSString
  def to_img
    UIImage.imageNamed(self)
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
end
