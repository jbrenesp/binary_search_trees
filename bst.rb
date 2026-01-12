class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=> (other)
    data <=> other.data
  end
end

class Tree
  
  def initialize(array)
    #accepts an array
   @array = array
   #it should have a root attribute
   @root = build_tree(array)
   #root uses the return value of tree
  end

  def build_tree(array)
  end

end
