class NSBox
  #Can't use boxType = NSBoxSeparator because that doesn't let us change the border color
  def self.borderBoxWithColor(color)
    NSBox.new.tap do |v|
      v.title = 'Separator'
      v.boxType = NSBoxCustom
      v.fillColor = color
      v.borderType = NSNoBorder
    end
  end
end
