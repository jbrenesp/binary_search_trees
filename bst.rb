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
  attr_accessor :root
  
  def initialize(array)
    #accepts an array
   @array = array
   #it should have a root attribute
   @root = build_tree(array)
   #root uses the return value of tree
  end

  def build_tree(array)
    #remove duplicates from array & sort array
    array = array.uniq.sort
    if array.empty?
      return nil
    end
      #find middle index
      mid = array.length / 2
      node = Node.new(array[mid])
      node.left = build_tree(array[0...mid])
      node.right = build_tree(array[mid+1..-1])
      
      return node
  end

  def insert(value)
    current = @root
    while current
      if value == current.data
        return 
      elsif value < current.data
        if current.left.nil?
          current.left = Node.new(value)
          return
        else 
          current = current.left
        end
      else 
        if current.right.nil?
          current.right = Node.new(value)
          return
        else 
          current = current.right
        end
      end
    end
  end
      
  






  
  def inorder(node = @root)
    return if node.nil?
    inorder(node.left)
    print "#{node.data} "
    inorder(node.right)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end


end

arr = [8, 4, 12]
tree = Tree.new(arr)

tree.insert(6)
tree.insert(10)
tree.insert(14)

tree.pretty_print  # or tree.inorder

