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

  def alert(title, message=nil)
    UIAlertController.alertControllerWithTitle(title, message:message, preferredStyle:UIAlertControllerStyleAlert).tap do |alert|
      alert.addAction(UIAlertAction.actionWithTitle('OK', style:UIAlertActionStyleDefault, handler:proc {|action|
        alert.dismissViewControllerAnimated(true, completion:nil)
      }))
    end
  end
end
PR = PurplishRed
