require_relative 'linked_list'
require_relative 'node'

class SeparateChaining
  attr_reader :max_load_factor

  def initialize(size)
    @max_load_factor = 0.7
    @total_keys = 0.0
    @buckets = Array.new(size)
  end

  def []=(key, value)
    i = index(key, self.size)
    if @buckets[i]
      @buckets[i].add_to_front(Node.new(key, value))
    else
      @buckets[i] = LinkedList.new
      @buckets[i].add_to_front(Node.new(key, value))
    end
    @total_keys += 1
    if self.load_factor > @max_load_factor
      self.resize
    end
  end

  def [](key)
    i = index(key, self.size)
    @buckets[i].find_node_by_key(key).value
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    hash_code = 0
    array_of_characters = key.split('')
    array_of_characters.each do |letter|
      hash_code += letter.ord
    end
    hash_code % size
  end

  # Calculate the current load factor
  def load_factor
    @total_keys / self.size
  end

  # Simple method to return the number of buckets in the hash
  def size
    @buckets.length
  end

  # Resize the hash
  def resize
    new_size = self.size * 2
    old_size = self.size
    old_bucket_hash = @buckets
    @buckets = Array.new(new_size)
    @total_keys = 0.0

    old_size.times do |i|
      if old_bucket_hash[i]
        current_node = old_bucket_hash[i].head
        assign_new_hash(current_node)
        while current_node.next
          current_node = current_node.next
          assign_new_hash(current_node)
        end
      end
    end
    @buckets
  end

  def print_hash
    p "This HashClass contains #{self.size} buckets
    with #{@total_keys} items and a load factor of #{self.load_factor}"
    self.size.times do |i|
      if @buckets[i]
        current_node = @buckets[i].head
        p "Key: #{current_node.key} with Value: #{current_node.value} is in bucket #{i}"
        while current_node.next
          p "Key: #{current_node.next.key} with Value: #{current_node.next.value} is next to Key: #{current_node.key} in bucket #{i}"
          current_node = current_node.next
        end
      end
    end
  end

  private

  def assign_new_hash(node)
    key = node.key
    value = node.value
    self[key]= value
  end
end
