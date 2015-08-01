class NSString
  def to_sound
    NSSound.soundNamed(self)
  end
end
