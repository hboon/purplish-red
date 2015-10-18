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

  def to_file_url
    NSURL.fileURLWithPath(self)
  end

  def to_url_request
    self.to_url.to_url_request
  end

  def path_in_main_bundle
    name = File.basename(self, '.*')
    extension = File.extname(self).delete('.')
    NSBundle.mainBundle.pathForResource(name, ofType:extension)
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

  def append_query_parameter(key, value)
    if include? '?'
      result = "#{self}&#{key}=#{value}"
    else
      result = "#{self}?#{key}=#{value}"
    end
  end

  def append_query_parameters(aDictionary)
    return self if aDictionary.empty?
    parameters = aDictionary.map {|k,v| "#{k}=#{v}"}.join('&')
    if include? '?'
      "#{self}&#{parameters}"
    else
      "#{self}?#{parameters}"
    end
  end

  def ensure_directory_exist(&block)
    if NSFileManager.defaultManager.fileExistsAtPath(self, isDirectory:nil)
      block.call(true, nil) if block
      return
    end
    error = Pointer.new(:object)
    NSFileManager.defaultManager.createDirectoryAtPath(self, withIntermediateDirectories:true, attributes:nil, error:error)
    if error[0]
      block.call(false, error[0]) if block
    else
      block.call(false, nil) if block
    end
  end

  def existing_file_path?
    is_directory = Pointer.new(:bool)
    exists = NSFileManager.defaultManager.fileExistsAtPath(self, isDirectory:is_directory)
    exists && !is_directory[0]
  end
end
