require_relative 'node'
require_relative 'myqueue'

class BinarySearchTree
  attr_accessor :root

  def initialize(root)
    @root = root
  end

  def insert(root, node)
    current_node = root
    not_inserted = true
    while not_inserted
      if node.rating < current_node.rating
        if current_node.left
          current_node = current_node.left
        else
          current_node.left = node
          node.parent = current_node
          not_inserted = false
        end
      else
        if current_node.right
          current_node = current_node.right
        else
          current_node.right = node
          node.parent = current_node
          not_inserted = false
        end
      end
    end
  end

  # Recursive Depth First Search
  def find(root, data)
    if data == nil
      return nil
    end
    current_node = root
    while current_node.title != data
      unless current_node.left || current_node.right
        return nil
      end
      if current_node.left
        current_node = current_node.left
      elsif current_node.right
        current_node = current_node.right
      elsif current_node != current_node.parent.right
        current_node = current_node.parent.right
      else
        if current_node.parent == current_node.parent.parent.right
          return nil
        else
          current_node = current_node.parent.parent.right
        end
      end
    end
    current_node
  end

  def delete(root, data)
    target_node = find(root, data)
    if target_node&.left and target_node&.right
      successor = target_node.right.find_min()
      successor.replace_node(target_node)
    elsif target_node&.left
      target_node.left.replace_node(target_node)
    elsif target_node&.right
      target_node.right.replace_node(target_node)
    else
      if target_node&.parent
        if target_node == target_node.parent&.left
          target_node.parent.left = nil
        else
          target_node.parent.right = nil
        end
        target_node&.parent = nil
      end
    end
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

  def find_min()
    current_node = self
    while current_node.left
      current_node = current_node.left
    end
    current_node
  end

  def replace_node(target_node)
    if target_node == target_node.parent.left
      target_node.parent.left = self
    else
      target_node.parent.right = self
    end
    self.parent = target_node.parent
    self.right = target_node.right
    self.left = target_node.left
  end

end
