require 'benchmark'
require_relative 'node'
require_relative 'linked_list'

linked_list = LinkedList.new
array = []
data = 0


Benchmark.bm do |x|
  puts "Build list/array wtih 10,000 items"
  x.report("Array") do
    10000.times do
      array.push("data")
    end
  end
  x.report("List") do
    10000.times do
      node = Node.new(data)
      linked_list.add_to_tail(node)
      data += 1
    end
  end
  puts "Access the 5,000th item"
  x.report("Array") do
    array[4999]
  end
  x.report("List") do
    linked_list.find_node_by_data(5000)
  end
  puts "Remove the 5,000th item"
  x.report("Array") do
    array.delete_at(4999)
  end
  x.report("List") do    
    node = linked_list.find_node_by_data(5000)
    linked_list.delete(node)
  end
end
