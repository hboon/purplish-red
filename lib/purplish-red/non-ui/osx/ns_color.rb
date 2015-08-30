class NSColor
  def grayscale_colorspace?
    numberOfComponents == 2
  end

  def components(aColorSpace=NSColorSpace.sRGBColorSpace)
    #Can't use Pointer.new(:float). 32-bit and 64-bit differences. https://hipbyte.freshdesk.com/support/tickets/2595
    c = colorUsingColorSpace(aColorSpace)
    if c.grayscale_colorspace?
      #kkk CGXXX, can they, do they need to be replaced?
      white = Pointer.new(CGSize.type[/(f|d)/])
      alpha = Pointer.new(CGSize.type[/(f|d)/])
      c.getWhite(white, alpha:alpha)
      [white[0], alpha[0]]
    else
      red = Pointer.new(CGSize.type[/(f|d)/])
      green = Pointer.new(CGSize.type[/(f|d)/])
      blue = Pointer.new(CGSize.type[/(f|d)/])
      alpha = Pointer.new(CGSize.type[/(f|d)/])
      c.getRed(red, green:green, blue:blue, alpha:alpha)
      [red[0], green[0], blue[0], alpha[0]]
    end
  end

  def red
    (components[0]*255).round
  end

  def green
    (components[1]*255).round
  end

  def blue
    (components[2]*255).round
  end

  def alpha
    if grayscale_colorspace?
      components[1]
    else
      components[3]
    end
  end

  def white
    components[0]
  end

  def color_with_alpha(a)
    comps = components
    UIColor.alloc.initWithRed(comps[0], green:comps[1], blue:comps[2], alpha:a)
  end

  def to_single_pt_image
    UIGraphicsBeginImageContext(CGSizeMake(1, 1))
    context = UIGraphicsGetCurrentContext()
    set
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1))
    result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    result
  end
end
