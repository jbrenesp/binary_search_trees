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
  
  def min_value_node(node)
    current = node
    current = current.left while current.left
    current
  end

  def delete(value, node=@root)
    return nil if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      if node.left.nil? && node.right.nil?
        return nil
      elsif node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      else
        successor = min_value_node(node.right) 
        node.data = successor.data
        node.right = delete(successor.data, node.right)
      end
    end
    node
  end

  def find(value)
    current = @root
    while current
      if value == current.data
        return current
      elsif value < current.data
        current = current.left
      else
        current = current.right
      end
    end
  end

  def level_order
    return [] if root.nil?
    queue = [root]
    result = []
    
    while !queue.empty?
      current = queue.shift
      if block_given?
        yield current
      else
        result << current.data
      end

      queue << current.left if current.left
      queue << current.right if current.right
    end
    result unless block_given?
  end

  
  
  def inorder(node = @root, result = [], &block )
    return result if node.nil?
    inorder(node.left, result, &block)

    if block
      block.call(node)
    else
      result << node.data
    end
    inorder(node.right, result, &block)

    result unless block
  end

  def preorder(node = @root, result = [], &block)
    return result if node.nil?
    if block 
      yield node
    else 
      result << node.data
    end
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)

    result unless block
  end

def post_order(node = @root, result = [], &block)
  return result if node.nil?
  post_order(node.left, result, &block)
  post_order(node.right, result, &block)
  if block 
    yield node
  else result << node.data
  end
  result unless block
end

def height(node_or_value)
  return -1 if node_or_value.nil?

  node = node_or_value.is_a?(Node) ? node_or_value : find(node_or_value)
  return nil if node.nil?

  helper = ->(n) do
    return -1 if n.nil?
    left_height = helper.call(n.left)
    right_height = helper.call(n.right)
    1 + [left_height, right_height].max
  end
  helper.call(node)
end

def depth(value)
   current = @root
   depth = 0

    while current
      if value == current.data
        return depth
      elsif value < current.data
        current = current.left
        depth += 1
      else
        current = current.right
        depth += 1
      end
    end
    return nil
  end

  def balanced?(node = @root)
    return true if node.nil? 

    left_height = height(node.left)
    right_height = height(node.right)
    puts "Node #{node.data}: left_height=#{left_height}, right_height=#{right_height}"
    
    return false if (left_height - right_height).abs >1
    
    balanced?(node.left) && balanced?(node.right)
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
tree.insert(2)
tree.insert(1)
tree.insert(0)
tree.insert(-1)



tree.pretty_print
puts "is the tree balanced? #{tree.balanced?}"




