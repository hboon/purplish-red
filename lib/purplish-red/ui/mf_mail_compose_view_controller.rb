class MFMailComposeViewController
  def self.compose(subject, options={})
    delegate = MOCommon::MailComposerDelegate.new
    delegate.on_finish = options[:finish]
    delegate.send(:retain)

    vc = MFMailComposeViewController.new
    vc.setSubject(subject)
    vc.setToRecipients(options[:recipients]) if options[:recipients]
    vc.setMessageBody(options[:body], isHTML:options[:is_html]) if options[:body]
    vc.mailComposeDelegate = delegate

    vc
  end
end

module MOCommon
  class MailComposerDelegate
    attr_accessor :on_finish

    def mailComposeController(vc, didFinishWithResult:result, error:error)
      on_finish.call(result, error)
      send(:autorelease)
    end
  end
end
