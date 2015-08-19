module CanSetTargetAction
  def on_action(&block)
    @callback = block
    @callback.weak!
    self.target = @callback
    if @callback
      if @callback.arity == 0
        self.action = 'call'
      else
        #Can only support at most 1 arg
        self.action = 'call:'
      end
    else
      self.action = nil
    end
  end
end
