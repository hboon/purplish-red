#Stuff I copied from MOCommon, some new
class UIImage
  M_PI = 3.14159265358979323846264338327950288

  def self.size_at_path(s)
    url = NSURL.fileURLWithPath(s)
    img_src = CGImageSourceCreateWithURL(url, nil)
    if img_src.nil?
      #p "Error loading image"
    else
      img_properties = CGImageSourceCopyPropertiesAtIndex(img_src, 0, KCGImageSourceShouldCache => false)
      if img_properties.nil?
        #p "Failed to get properties for image"
      else
        return CGSizeMake(img_properties[KCGImagePropertyPixelWidth], img_properties[KCGImagePropertyPixelHeight])
      end
    end
    CGSizeZero
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

  def scale_to_size(s)
    s = s.to_size
    color_space = CGColorSpaceCreateDeviceRGB()
    context = CGBitmapContextCreate(nil, s.width*scale, s.height*scale, 8, s.width*4*scale, color_space, KCGImageAlphaPremultipliedLast)
    img_ref = self.CGImage
    CGContextDrawImage(context, CGRectMake(0, 0, s.width*scale, s.height*scale), img_ref)
    copy = CGBitmapContextCreateImage(context)
    UIImage.imageWithCGImage(copy, scale:scale, orientation:imageOrientation)
  end

  #Preserve aspect ratio while scaling. E.g if s = (612,612), the longer side will be 612 and the shorter side will be at most 612
  def scale_aspect_to_maximum_size(s)
    scale_to_size(size.scale_to_fit(s))
  end

  #Preserve aspect ratio while scaling. E.g if s = (612,612), the shorter side will be 612 and the shorter side will be at least 612
  def scale_aspect_to_minimum_size(s)
    scale_to_size(size.scale_to_fill(s))
  end

  #Preserve aspect ratio while scaling to fill. Part of the content may be clipped
  def scale_aspect_to_fill_size(s)
    s = s.to_size
    if s.width/s.height > size.width/size.height
      cropped_img = image_by_cropping_to_center_size(CGSize.new(size.width, (size.width/s.width * s.height).to_i))
    else
      cropped_img = image_by_cropping_to_center_size(CGSize.new((size.height/s.height * s.width).to_i, size.height))
    end

    cropped_img.scale_to_size(s)
  end

  #aRect is assumed to be in the "same scale" as self
  def image_by_cropping_to_rect(aRect)
    if aRect.is_a? CGRect
      cropped = CGImageCreateWithImageInRect(CGImage, [[aRect.origin.x*scale, aRect.origin.y*scale], [aRect.size.width*scale, aRect.size.height*scale]])
    else
      cropped = CGImageCreateWithImageInRect(CGImage, [[aRect[0][0]*scale, aRect[0][1]*scale], [aRect[1][0]*scale, aRect[1][1]*scale]])
    end
    UIImage.imageWithCGImage(cropped, scale:scale, orientation:imageOrientation)
  end

  def image_by_cropping_to_center_size(s)
    s = s.to_size
    if s.width/s.height > size.width/size.height
      return image_by_cropping_to_rect(CGRect.new([0, (size.height-s.height)/2], [s.width, s.height]))
    else
      return image_by_cropping_to_rect(CGRect.new([(size.width-s.width)/2, 0], [s.width, s.height]))
    end
  end

  def rotate_with_orientation(new_orientation)
    #Front camera? We try to make fix it
    if (size.width == 640 && size.height == 480) || (size.width == 480 && size.height == 640)
      p 'Front camera photo'
      if new_orientation == UIImageOrientationUp
        #EXIF = 1
      elsif new_orientation == UIImageOrientationDown
        #EXIF = 3
        new_orientation = UIImageOrientationLeftMirrored
      elsif new_orientation == UIImageOrientationLeft
        #EXIF = 6
      elsif new_orientation == UIImageOrientationRight
        #EXIF = 8
        new_orientation = UIImageOrientationLeftMirrored
      elsif new_orientation == UIImageOrientationUpMirrored
        #EXIF = 2
      elsif new_orientation == UIImageOrientationDownMirrored
        #EXIF = 4
      elsif new_orientation == UIImageOrientationLeftMirrored
        #EXIF = 5
      elsif UIImageOrientationRightMirrored
        #EXIF = 7
        new_orientation = UIImageOrientationRightMirrored
      end
    else
      p 'Not front camera photo'
    end

    img_ref = CGImage
    width = CGImageGetWidth(img_ref)
    height = CGImageGetHeight(img_ref)
    transform = CGAffineTransformIdentity
    bounds = CGRect.new([0, 0], [width, height])
    img_size = CGSize.new(width, height)

    if new_orientation == UIImageOrientationUp
      #EXIF = 1
      transform = CGAffineTransformIdentity
    elsif new_orientation == UIImageOrientationUpMirrored
      #EXIF = 2
      transform = CGAffineTransformMakeTranslation(img_size.width, 0.0)
      transform = CGAffineTransformScale(transform, -1.0, 1.0)
    elsif new_orientation == UIImageOrientationDown
      #EXIF = 3
      transform = CGAffineTransformMakeTranslation(img_size.width, img_size.height)
      transform = CGAffineTransformRotate(transform, M_PI)
    elsif new_orientation == UIImageOrientationDownMirrored
      #EXIF = 4
      transform = CGAffineTransformMakeTranslation(0.0, img_size.height)
      transform = CGAffineTransformScale(transform, 1.0, -1.0)
    elsif new_orientation == UIImageOrientationLeftMirrored
      #EXIF = 5
      bounds_height = bounds.size.height
      bounds.size.height = bounds.size.width
      bounds.size.width = bounds_height
      transform = CGAffineTransformMakeTranslation(img_size.height, img_size.width)
      transform = CGAffineTransformScale(transform, -1.0, 1.0)
      transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0)
    elsif new_orientation == UIImageOrientationLeft
      #EXIF = 6
      bounds_height = bounds.size.height
      bounds.size.height = bounds.size.width
      bounds.size.width = bounds_height
      transform = CGAffineTransformMakeTranslation(0.0, img_size.width)
      transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0)
    elsif new_orientation == UIImageOrientationRightMirrored
      #EXIF = 7
      bounds_height = bounds.size.height
      bounds.size.height = bounds.size.width
      bounds.size.width = bounds_height
      transform = CGAffineTransformMakeScale(-1.0, 1.0)
      transform = CGAffineTransformRotate(transform, M_PI / 2.0)
    elsif new_orientation == UIImageOrientationRight
      #EXIF = 8
      bounds_height = bounds.size.height
      bounds.size.height = bounds.size.width
      bounds.size.width = bounds_height
      transform = CGAffineTransformMakeTranslation(img_size.height, 0.0)
      transform = CGAffineTransformRotate(transform, M_PI / 2.0)
    end

    UIGraphicsBeginImageContext(bounds.size)
    context = UIGraphicsGetCurrentContext()

    if new_orientation == UIImageOrientationRight || new_orientation == UIImageOrientationLeft
      CGContextScaleCTM(context, -1, 1)
      CGContextTranslateCTM(context, -height, 0)
    elsif new_orientation == UIImageOrientationLeft || new_orientation == UIImageOrientationLeftMirrored || new_orientation == UIImageOrientationRightMirrored
      CGContextScaleCTM(context, 1, -1)
      CGContextTranslateCTM(context, 0, -width)
    else
      CGContextScaleCTM(context, 1, -1)
      CGContextTranslateCTM(context, 0, -height)
    end

    CGContextConcatCTM(context, transform)

    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRect.new([0, 0], [width, height]), img_ref)
    img_copy = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    img_copy
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
            }, failureBlock:proc {|err|
              #p "failed to retrieve image asset. Error: #{err.localizedDescription}"
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
    rect = rect.to_rect.scale(scale)
    img_ref = CGImageCreateWithImageInRect(self.CGImage, rect)
    img = UIImage.imageWithCGImage(img_ref, scale:UIScreen.mainScreen.scale, orientation:UIImageOrientationUp)
    img
  end
end
