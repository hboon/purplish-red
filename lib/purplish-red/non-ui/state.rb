if Object.const_defined?('PurplishRed')
  NSNotificationCenter.defaultCenter.addObserverForName(UIApplicationDidFinishLaunchingNotification, object:nil, queue:nil, usingBlock:lambda do |notification|
    PurplishRed.app_resumed = false
  end)

  NSNotificationCenter.defaultCenter.addObserverForName(UIApplicationWillEnterForegroundNotification, object:nil, queue:nil, usingBlock:lambda do |notification|
    PurplishRed.app_resumed = true
  end)
end
