require_relative 'node'
require_relative 'myqueue'

class MinBinaryHeap

  attr_accessor :root
  attr_accessor :bottom_node

  def initialize(root)
    @root = root
    @bottom_node = root
  end

  def insert(root, node)
    # if @bottom_node.rating == 92
    #   p @bottom_node.rating
    #   p @bottom_node.parent.rating
    #   p @bottom_node.parent&.right&.rating
    # end
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
      p @bottom_node.rating
    re_order()
    end
  end

  private

  def assign_bottom_node(new_node, parent)
    new_node.parent = parent
    @bottom_node = new_node
  end

  # Maybe not swaping nodes correctly
  # write test?
  def node_swap(parent_node, child_node)
    p "parent #{parent_node.rating}"
  #  p "parent left child #{parent_node&.left&.rating}"
    p "child #{child_node.rating}"
    p "root #{@root.rating}"
    p "root.right.left #{@root&.right&.left&.rating}"
    child_node_left_placeholder = child_node&.left || nil
    child_node_right_placeholder = child_node&.right || nil
    child_node&.left&.parent = parent_node
    child_node&.right&.parent = parent_node
    if child_node == parent_node&.left
      child_node.left = parent_node
      child_node.right = parent_node.right
      parent_node&.right&.parent = child_node
    else
      child_node.left = parent_node.left
      child_node.right = parent_node
      parent_node&.left&.parent = child_node
    end
    child_node.parent = parent_node&.parent
    if parent_node.parent
      if parent_node = parent_node.parent.left
        parent_node.parent.left = child_node
      else
        parent_node.parent.right = child_node
      end
    else
      @root = child_node
    end
    parent_node.parent = child_node
    parent_node.left = child_node_left_placeholder
    parent_node.right = child_node_right_placeholder
    @bottom_node = parent_node if child_node == @bottom_node
    p "root.right #{@root&.right&.rating}"
  end

  def re_order()
    child_node = @bottom_node
    parent_node = @bottom_node.parent

    while child_node.rating < parent_node.rating
      # p child_node.rating
      # p parent_node.rating
      node_swap(parent_node, child_node)
      parent_node = child_node.parent
      return if parent_node == nil
    end
  end
end
