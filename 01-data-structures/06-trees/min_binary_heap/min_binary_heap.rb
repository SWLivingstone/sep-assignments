require_relative 'node'
require_relative 'myqueue'

class MinBinaryHeap

  attr_accessor :root
  attr_accessor :bottom_node

  def initialize(root)
    @root = root
    @bottom_node = root
  end

  def insert(node)
    if @bottom_node.parent
      if @bottom_node.parent.right == nil
        @bottom_node.parent.right = node
        assign_bottom_node(node, @bottom_node.parent)
      else
        current_node = @bottom_node
        previous_node = nil
        while current_node&.parent&.right == current_node
          previous_node = current_node
          current_node = current_node.parent
        end
        if previous_node != current_node.right
          current_node = current_node.right
        elsif current_node&.parent&.right
          current_node = current_node.parent.right
        end
        while current_node.left
          current_node = current_node.left
        end
        current_node.left = node
        assign_bottom_node(node, current_node)
      end
    else
      @bottom_node.left = node
      assign_bottom_node(node, @bottom_node)
    end
    if @bottom_node.rating < @bottom_node.parent.rating
    re_order(@bottom_node)
    end
  end

  def find(data)
    if data == nil
      return nil
    end
    current_node = @root
    while current_node&.title != data
      if current_node&.left
        current_node = current_node.left
      elsif current_node&.right
        current_node = current_node.right
      elsif !current_node&.parent
        return nil
      elsif current_node != current_node&.parent&.right
        current_node = current_node.parent.right
      elsif current_node.parent.parent
        if current_node.parent == current_node.parent.parent.right
          return nil
        else
          current_node = current_node.parent.parent.right
        end
      else
        return nil
      end
      if current_node == false
        return nil
      end
    end
    current_node
  end

  def delete(data)
    target_node = find(data)
    target_node.title = @bottom_node.title
    target_node.rating = @bottom_node.rating
    if @bottom_node.parent
      new_bottom_node = find_new_bottom()
    else
      @root = nil
      return "The only node in the heap has been deleted"
    end
    delete_bottom_node()
    @bottom_node = new_bottom_node
    bubble_down(target_node)
  end

  # Recursive Breadth First Search
  def printf(children=nil)
    list = ""
    queue = MyQueue.new()
    queue.enqueue(@root)
    while queue.empty? != true
      list << "#{queue.head.title}: #{queue.head.rating}\n"
      queue.enqueue(queue.head&.left) if queue.head.left
      queue.enqueue(queue.head&.right)  if queue.head.right
      queue.dequeue
    end
    p list
  end

  private

  def assign_bottom_node(new_node, parent)
    new_node.parent = parent
    @bottom_node = new_node
  end

  def node_swap(parent_node, child_node)
    child_node_title = child_node.title
    child_node_rating = child_node.rating
    child_node.rating = parent_node.rating
    child_node.title = parent_node.title
    parent_node.title = child_node_title
    parent_node.rating = child_node_rating
  end

  def re_order(node)
    child_node = node
    parent_node = node.parent

    while child_node.rating < parent_node.rating
      node_swap(parent_node, child_node)
      child_node = parent_node
      parent_node = parent_node.parent
      return if parent_node == nil
    end
  end

  def bubble_down(node)
    while node&.left || node&.right
      if node.left && node.right
        if node.left.rating < node.right.rating
          node_swap(node, node.left)
          node = node.left
        else
          node_swap(node, node.right)
          node = node.left
        end
      else
        node_swap(node, node.left)
        node = node.left
      end
    end
  end

  def find_new_bottom()
    if @bottom_node.parent.left != @bottom_node
      new_bottom_node = @bottom_node.parent.left
    else
      current_node = @root
      while current_node.right
        current_node = current_node.right
      end
      new_bottom_node = current_node
    end
  end

  def delete_bottom_node()
    if @bottom_node.parent.right == @bottom_node
      @bottom_node.parent.right = nil
    else
      @bottom_node.parent.left = nil
    end
    @bottom_node.parent = nil
  end
end
