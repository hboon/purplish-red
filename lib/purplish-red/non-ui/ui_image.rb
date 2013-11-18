#Stuff I copied from MOCommon, some new
class UIImage
  M_PI = 3.14159265358979323846264338327950288

  def self.size_at_path(s)
    imageFileURL = NSURL.fileURLWithPath(s)
    imageSource = CGImageSourceCreateWithURL(imageFileURL, nil)
    if imageSource.nil?
      #p "Error loading image"
    else
      imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, {KCGImageSourceShouldCache => false})
      if imageProperties.nil?
        #p "Failed to get properties for image"
      else
        return CGSizeMake(imageProperties[KCGImagePropertyPixelWidth], imageProperties[KCGImagePropertyPixelHeight])
      end
    end

    return CGSizeZero
  end


  def to_btn
    b = UIButton.buttonWithType(UIButtonTypeCustom)
    b.setImage(self, forState:UIControlStateNormal)
    b.frame = [[0, 0], [size.width, size.height]]
    b
  end

  def to_imgv
    UIImageView.alloc.initWithImage(self)
  end


  def width
    size.width
  end


  def height
    size.height
  end


  def scale_aspect_to_size(size)
    scale_aspect_to_maximum_size(size)
  end


  def scale_to_size(size)
    colorSpace = CGColorSpaceCreateDeviceRGB()

    context = CGBitmapContextCreate(nil, size.width*scale, size.height*scale, 8, size.width*4*scale, colorSpace, KCGImageAlphaPremultipliedLast)
    imageReference = self.CGImage
    CGContextDrawImage(context, CGRectMake(0, 0, size.width*scale, size.height*scale), imageReference)
    copy = CGBitmapContextCreateImage(context)
    UIImage.imageWithCGImage(copy, scale:scale, orientation:imageOrientation)
  end


  #Preserve aspect ratio while scaling. E.g if aSize = (612,612), the longer side will be 612 and the shorter side will be at most 612
  def scale_aspect_to_maximum_size(aSize)
    if aSize.width/aSize.height > self.size.width/self.size.height
      s = CGSize.new((aSize.height/size.height * size.width).to_i, aSize.height)
    else
      s = CGSize.new(aSize.width, (aSize.width/size.width * size.height).to_i)
    end

    scale_to_size(s)
  end


  #Preserve aspect ratio while scaling. E.g if aSize = (612,612), the shorter side will be 612 and the shorter side will be at least 612
  def scale_aspect_to_minimum_size(aSize)
    if aSize.width/aSize.height > self.size.width/self.size.height
      s = CGSize.new(aSize.width, (aSize.width/size.width * size.height).to_i)
    else
      s = CGSize.new((aSize.height/size.height * size.width).to_i, aSize.height)
    end

    scale_to_size(s)
  end


  #Preserve aspect ratio while scaling to fill. Part of the content may be clipped
  def scale_aspect_to_fill_size(aSize)
    if aSize.width/aSize.height > size.width/size.height
      croppedImg = image_by_cropping_to_center_size(CGSize.new(size.width, (size.width/aSize.width * aSize.height).to_i))
    else
      croppedImg = image_by_cropping_to_center_size(CGSize.new((size.height/aSize.height * aSize.width).to_i, size.height))
    end

    croppedImg.scale_to_size(aSize)
  end


  #aRect is assumed to be in the "same scale" as self
  def image_by_cropping_to_rect(aRect)
    if aRect.is_a? CGRect
      cropped = CGImageCreateWithImageInRect(self.CGImage, [[aRect.origin.x*self.scale, aRect.origin.y*self.scale], [aRect.size.width*self.scale, aRect.size.height*self.scale]])
    else
      cropped = CGImageCreateWithImageInRect(self.CGImage, [[aRect[0][0]*self.scale, aRect[0][1]*self.scale], [aRect[1][0]*self.scale, aRect[1][1]*self.scale]])
    end
    UIImage.imageWithCGImage(cropped, scale:self.scale, orientation:self.imageOrientation)
  end


  def image_by_cropping_to_center_size(aSize)
    if aSize.width/aSize.height > size.width/size.height
      return image_by_cropping_to_rect(CGRect.new([0, (size.height-aSize.height)/2], [aSize.width, aSize.height]))
    else
      return image_by_cropping_to_rect(CGRect.new([(size.width-aSize.width)/2, 0], [aSize.width, aSize.height]))
    end
  end


  def rotate_with_orientation(anOrientation)
    #Front camera? We try to make fix it
    if (size.width == 640 && size.height == 480) || (size.width == 480 && size.height == 640)
      p 'Front camera photo'
      if anOrientation == UIImageOrientationUp
        #EXIF = 1
      elsif anOrientation == UIImageOrientationDown
        #EXIF = 3
        anOrientation = UIImageOrientationLeftMirrored
      elsif anOrientation == UIImageOrientationLeft
        #EXIF = 6
      elsif anOrientation == UIImageOrientationRight
        #EXIF = 8
        anOrientation = UIImageOrientationLeftMirrored
      elsif anOrientation == UIImageOrientationUpMirrored
        #EXIF = 2
      elsif anOrientation == UIImageOrientationDownMirrored
        #EXIF = 4
      elsif anOrientation == UIImageOrientationLeftMirrored
        #EXIF = 5
      elsif UIImageOrientationRightMirrored
        #EXIF = 7
        anOrientation = UIImageOrientationRightMirrored
      end
    elsif
      p 'Not front camera photo'
    end	

    imgRef = self.CGImage
    width = CGImageGetWidth(imgRef)
    height = CGImageGetHeight(imgRef)
    transform = CGAffineTransformIdentity
    bounds = CGRect.new([0, 0], [width, height])
    imageSize = CGSize.new(width, height)

    if anOrientation == UIImageOrientationUp
      #EXIF = 1
      transform = CGAffineTransformIdentity
    elsif anOrientation == UIImageOrientationUpMirrored
      #EXIF = 2
      transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0)
      transform = CGAffineTransformScale(transform, -1.0, 1.0)
    elsif anOrientation == UIImageOrientationDown
      #EXIF = 3
      transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height)
      transform = CGAffineTransformRotate(transform, M_PI)
    elsif anOrientation == UIImageOrientationDownMirrored
      #EXIF = 4
      transform = CGAffineTransformMakeTranslation(0.0, imageSize.height)
      transform = CGAffineTransformScale(transform, 1.0, -1.0)
    elsif anOrientation == UIImageOrientationLeftMirrored
      #EXIF = 5
      boundHeight = bounds.size.height
      bounds.size.height = bounds.size.width
      bounds.size.width = boundHeight
      transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width)
      transform = CGAffineTransformScale(transform, -1.0, 1.0)
      transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0)
    elsif anOrientation == UIImageOrientationLeft
      #EXIF = 6
      boundHeight = bounds.size.height
      bounds.size.height = bounds.size.width
      bounds.size.width = boundHeight
      transform = CGAffineTransformMakeTranslation(0.0, imageSize.width)
      transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0)
    elsif anOrientation == UIImageOrientationRightMirrored
      #EXIF = 7
      boundHeight = bounds.size.height
      bounds.size.height = bounds.size.width
      bounds.size.width = boundHeight
      transform = CGAffineTransformMakeScale(-1.0, 1.0)
      transform = CGAffineTransformRotate(transform, M_PI / 2.0)
    elsif anOrientation == UIImageOrientationRight
      #EXIF = 8
      boundHeight = bounds.size.height
      bounds.size.height = bounds.size.width
      bounds.size.width = boundHeight
      transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0)
      transform = CGAffineTransformRotate(transform, M_PI / 2.0)
    end

    UIGraphicsBeginImageContext(bounds.size)
    context = UIGraphicsGetCurrentContext()

    if anOrientation == UIImageOrientationRight || anOrientation == UIImageOrientationLeft
      CGContextScaleCTM(context, -1, 1)
      CGContextTranslateCTM(context, -height, 0)
    elsif anOrientation == UIImageOrientationLeft || anOrientation == UIImageOrientationLeftMirrored || anOrientation == UIImageOrientationRightMirrored
      CGContextScaleCTM(context, 1, -1)
      CGContextTranslateCTM(context, 0, -width)
    else
      CGContextScaleCTM(context, 1, -1)
      CGContextTranslateCTM(context, 0, -height)
    end

    CGContextConcatCTM(context, transform)

    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRect.new([0, 0], [width, height]), imgRef)
    imageCopy = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    imageCopy
  end


  def rotate_to_correct_orientation
	  rotate_with_orientation(imageOrientation)
  end


  def show_globally
    img = self
    if img.width > UIScreen.mainScreen.bounds.size.width || img.height > UIScreen.mainScreen.bounds.size.height
      img = img.scale_aspect_to_size(UIScreen.mainScreen.bounds.size)
    end
    btn = img.to_btn
    btn.addTarget(btn, action:'removeFromSuperview', forControlEvents:UIControlEventTouchUpInside)
    parent = App.delegate.window
    btn.backgroundColor = UIColor.blackColor
    btn.center_x = parent.width/2
    btn.center_y = parent.height/2
    parent.addSubview(btn)
  end


  def save_to_album_named(album_name, meta_data:meta_data)
    if ALAssetsLibrary.authorizationStatus == ALAuthorizationStatusRestricted || ALAssetsLibrary.authorizationStatus == ALAuthorizationStatusDenied
      UIImageWriteToSavedPhotosAlbum(self, nil, nil, nil)
    else
      ALAssetsLibrary.new.album_name(album_name) do |library, album|
        p = proc {|assetURL, error|
          if error.nil?
            library.assetForURL(assetURL, resultBlock:proc {|asset|
              #Might fail with no group (album) found. Perhaps a shared photostream has the same album name, we wouldn't be able to write to it, yet can't create an album of the same name
              if album.nil?
                UIImageWriteToSavedPhotosAlbum(self, nil, nil, nil)
              else
                album.addAsset(asset)
              end
            }, failureBlock:proc {|error|
              #p "failed to retrieve image asset. Error: #{error.localizedDescription}"
            })
          else
            #p "saved image failed. Error code: #{error.code} desc: #{error.localizedDescription}"
          end
        }
        if meta_data.nil?
          library.writeImageToSavedPhotosAlbum(self.CGImage, orientation:imageOrientation, completionBlock:p)
        else
          library.writeImageToSavedPhotosAlbum(self.CGImage, metadata:meta_data, completionBlock:p)
        end
      end
    end
  end


  #rect must be in pts, not px
  def cut_image_with_rect(rect)
    if rect.is_a? Array
      rect = [[rect[0][0]*scale, rect[0][1]*scale], [rect[1][0]*scale, rect[1][1]*scale]]
    else
      rect = [[rect.origin.x*scale, rect.origin.y*scale], [rect.size.width*scale, rect.size.height*scale]]
    end
    img_ref = CGImageCreateWithImageInRect(self.CGImage, rect)
    img = UIImage.imageWithCGImage(img_ref, scale:UIScreen.mainScreen.scale, orientation:UIImageOrientationUp)
    img
  end
end
