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
    child_node_left_placeholder = child_node&.left
    child_node_right_placeholder = child_node&.right
    if child_node == parent_node&.left
      child_node.left = parent_node
      child_node.right = parent_node.right
    else
      child_node.left = parent_node.left
      child_node.right = parent_node.right
    end
    child_node.parent = parent_node&.parent
    parent_node.parent = child_node
    parent_node.left = child_node_left_placeholder
    parent_node.right = child_node_right_placeholder
    @bottom_node = parent_node if child_node == @bottom_node
    @root = child_node if parent_node == @root
  end

  def re_order()
    child_node = @bottom_node
    parent_node = @bottom_node.parent

    while child_node.rating < parent_node.rating
      node_swap(parent_node, child_node)
      parent_node = child_node.parent
      p @root.title
      p @root.left.title
      return if parent_node == nil
    end
  end
end
