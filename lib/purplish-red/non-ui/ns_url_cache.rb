class NSURLCache
  def stats
    "Disk: #{NSURLCache.sharedURLCache.currentDiskUsage/1000000}/#{NSURLCache.sharedURLCache.diskCapacity/1000000} Mem: #{NSURLCache.sharedURLCache.currentMemoryUsage/1000000}/#{NSURLCache.sharedURLCache.memoryCapacity/1000000} (MB)"
  end
end
