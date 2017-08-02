class MyStack
  attr_accessor :top

  def initialize
    @stack = Array.new
    self.top = nil
  end

  def push(item)
    @stack[@stack.length] = item
    self.top = @stack[-1]
  end

  def pop
    self.top = @stack[-2]
    @stack.delete_at(-1)
  end

  def empty?
    if @stack.length == 0
      true
    else
      false
    end
  end
end
