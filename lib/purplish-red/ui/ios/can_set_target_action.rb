module CanSetTargetAction
  def on_action(events=UIControlEventTouchUpInside, &block)
    return unless block
    @callback = block
    @callback.weak!
    if @callback.arity == 0
      addTarget(@callback, action: 'call', forControlEvents: events)
    else
      #Can only support at most 1 arg
      addTarget(@callback, action: 'call:', forControlEvents: events)
    end
  end
end
