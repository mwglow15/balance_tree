class Tree
  attr_accessor :root


  def initialize(array)
    p array.sort.uniq
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(array)
    array_start = 0
    array_end = array.length
    mid = array.length / 2

    return nil if array_start >= mid

    node = Node.new(array[mid])
    
    node.left = build_tree(array[array_start,mid])
    node.right = build_tree(array[mid, array_end])

    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value,node=@root)
    if value < node.data
      insert(value,node.left) unless node.left.nil?
      node.left = Node.new(value) if node.left.nil?
    else
      insert(value,node.right) unless node.right.nil?
      node.right = Node.new(value) if node.right.nil?
    end
  end

  def delete(value)

  end

  def find(value, node = @root)
    return node if value == node.data

    
  end
end

class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

a = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
a.insert(4)
p a.pretty_print