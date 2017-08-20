class Node
  attr_accessor :title
  attr_accessor :rating
  attr_accessor :left
  attr_accessor :right
  attr_accessor :parent

  def initialize(title, rating)
    @title = title
    @rating = rating
    @left = false
    @right = false
    @parent = false
  end
end
