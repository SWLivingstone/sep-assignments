require 'benchmark'
require_relative 'binary_tree/node'
require_relative 'binary_tree/binary_search_tree'
require_relative 'min_binary_heap/min_binary_heap'
root = Node.new("1", 1)
tree = BinarySearchTree.new(root)
heap = MinBinaryHeap.new(root)


Benchmark.bm do |x|
  puts "Insert 1 to 10,000"
  x.report("Tree") do
    count = 2
    10000.times do
      tree.insert(root, Node.new("#{count}", count))
      count += 1
    end
  end
  x.report("Heap") do
    count = 2
    10000.times do
      heap.insert(Node.new("#{count}", count))
      count +=1
    end
  end
  puts "Find the 5,000th node"
  x.report("Tree") do
    tree.find(root, "5000")
  end
  x.report("Heap") do
    heap.find("5000")
  end
  puts "Delete the 5,000th item"
  x.report("Tree") do
    tree.delete(root, "5000")
  end
  x.report("Heap") do
    heap.delete("5000")
  end
end
