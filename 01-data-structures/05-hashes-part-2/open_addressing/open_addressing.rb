require_relative 'node'

class OpenAddressing
  attr_accessor :items

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    i = index(key, self.size)
    if @items[i]
      while @items[i] && @items[i].key != key
        i += 1
      end
      if i >= self.size
        self.resize
        return self[key]= value
      end
    end
    @items[i] = Node.new(key, value)
  end

  def [](key)
    i = index(key, self.size)
    while @items[i].key != key || i > self.size
      i += 1
    end
    @items[i].value
  end


  def index(key, size)
    hash_code = 0
    array_of_characters = key.split('')
    array_of_characters.each do |letter|
      hash_code += letter.ord
    end
    hash_code % size
  end

  # Given an index, find the next open index in @items
  def next_open_index(i)
    while @items[i]
      i += 1
    end
    return i < self.size ? i : -1
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end

  # Resize the hash
  def resize
    new_size = self.size * 2
    new_item_hash = Array.new(new_size)

    self.size.times do |i|
      if @items[i]
        key = @items[i].key
        value = @items[i].value
        new_item_hash[index(key, new_size)] = Node.new(key,value)
      end
    end
    @items = new_item_hash
  end
end
