module Enumerable
  def map_with_index(&block)
    [].tap do |result|
      each_with_index do |e, i|
        if block
          result << block.call(e, i)
        else
          result << [e, i]
        end
      end
    end
  end
end
