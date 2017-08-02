class MyQueue
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @queue = Array.new
    @head = @queue[0]
    @tail = @queue[0]
  end

  def enqueue(element)
    @queue[@queue.length] = element
    @tail = @queue[-1]
    @head = @queue[0]
  end

  def dequeue
    @queue.delete_at(0)
    @head = @queue[0]
  end

  def empty?
    if @queue.length == 0
      true
    else
      false
    end
  end
end
