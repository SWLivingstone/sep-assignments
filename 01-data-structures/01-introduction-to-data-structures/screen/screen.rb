require_relative 'pixel'

class Screen
  attr_accessor :width
  attr_accessor :height
  attr_accessor :matrix

  def initialize(width, height)
    @screen = create_grid(width, height)
  end

  # Insert a Pixel at x, y
  def insert(pixel, x, y)
    if inbounds(x, y)
      @screen[y][x] = pixel
    else
      puts "Those pixels are not valid"
    end
  end

  def at(x, y)
    if inbounds(x, y)
      @screen[y][x]
    else
      nil
    end
  end

  private

  def create_grid(width, height)
    grid = []
    height.times do |i|
      grid[i] = []
      width.times do
        grid[i].push([])
      end
    end
    return grid
  end

  def inbounds(x, y)
    if x < 0 or y < 0
      false
    elsif y > @screen.length or x > @screen[0].length
      false
    else
      true
    end
  end

end
