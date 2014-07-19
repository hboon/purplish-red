module PurplishRed
  def self.app_resumed=(b)
    @app_resumed = b
  end

  def self.app_resumed?
    @app_resumed
  end

  module_function

  def osx?
    Kernel.const_defined?(:NSApplication)
  end

  def ios?
    Kernel.const_defined?(:UIApplication)
  end
end
