require_relative 'hash_item'

class HashClass
  attr_accessor :items

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    i = index(key, self.size)
    if @items[i]
      if @items[i].value != value
          self.resize
          i = index(key, self.size)
          self[key]= value
      end
    else
      @items[i] = HashItem.new(key, value)
    end
  end


  def [](key)
    i = index(key, self.size)
    @items[i].value
  end

  def resize
    new_size = self.size * 2
    new_item_hash = Array.new(new_size)

    self.size.times do |i|
      if @items[i]
        key = @items[i].key
        value = @items[i].value
        new_item_hash[index(key, new_size)] = HashItem.new(key,value)
      end
    end
    @items = new_item_hash
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

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end

end
