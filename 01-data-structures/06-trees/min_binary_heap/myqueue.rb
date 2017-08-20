class MyQueue
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @queue = Array.new
    @head = @queue.last
    @tail = @queue.first
  end

  def enqueue(element)
    @queue.push(element)
    @tail = @queue.last
    @head = @queue.first
  end

  def dequeue
    @queue.shift
    @head = @queue.first
  end

  def empty?
    if @queue.length == 0
      true
    else
      false
    end
  end
end
