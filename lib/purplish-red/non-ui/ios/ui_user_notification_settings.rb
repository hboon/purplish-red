class UIUserNotificationSettings
  def badge?
    types & UIUserNotificationTypeBadge > 0
  end
  def sound?
    types & UIUserNotificationTypeSound > 0
  end
  def alert?
    types & UIUserNotificationTypeAlert > 0
  end
end
