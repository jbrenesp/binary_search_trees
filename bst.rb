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

# Example array
arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

# Create the tree
tree = Tree.new(arr)

# Print the inorder traversal
puts "Inorder traversal of the BST:"
tree.inorder
puts  # just to add a newline at the end
puts "Root: #{tree.root.data}"
puts "Root Left Child: #{tree.root.left.data}"
puts "Root Right Child: #{tree.root.right.data}"
tree.inorder
puts
tree.pretty_print

