class Proc
  #this Proc must accept a no-args proc that it will call when operation has completed
  def do_with_background_task
    task_id = UIApplication.sharedApplication.beginBackgroundTaskWithExpirationHandler(proc {
      break if task_id == UIBackgroundTaskInvalid
      UIApplication.sharedApplication.endBackgroundTask(task_id)
    })
    end_task_block = proc {
      return if task_id == UIBackgroundTaskInvalid
      UIApplication.sharedApplication.endBackgroundTask(task_id)
    }
    self.call(end_task_block)
  end
end
