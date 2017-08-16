require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  # This method creates a new `Node` using `value`, and inserts it at the end of the list.
  def add_to_tail(node)
    if @tail
      @tail.next = node
    end
    @tail = node
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    if @head == @tail
      return @tail = nil
    end
    node = @head
    while node.next
      @tail = node
      node = node.next
    end
  end

  # This method prints out a representation of the list.
  def print
    node = @head
    while node.next
      puts node.value
      node = node.next
    end
    puts node.value
  end

  # This method removes `node` from the list and must keep the rest of the list intact.
  def delete(node)
    if node == @head
      remove_front
    elsif node == @tail
      remove_tail
    else
      current_node = @head
      while current_node.next != node
        current_node = current_node.next
      end
      current_node.next = current_node.next.next
    end
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    if @head
      node.next = @head
    end
    @head = node
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    @head = @head.next
  end

  def find_node_by_key(node_key)
    current_node = @head
    while current_node.key != node_key
      current_node = current_node.next
    end
    return current_node
  end
end
