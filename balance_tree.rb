class Tree

  def initialize(array)
    p array.sort
    @root = build_tree(array.sort)
  end

  def build_tree(array)
    array_start = 0
    array_end = array.length
    mid = array.length / 2

    return nil if array_start >= mid

    node = Node.new(array[mid-1])
    
    node.left_node = build_tree(array[array_start,mid])
    node.right_node = build_tree(array[mid, array_end])

    node
  end

end

class Node
  attr_accessor :data, :left_node, :right_node

  def initialize(data)
    @data = data
    @left_node = nil
    @right_node = nil
  end
end

a = Tree.new([1, 6, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p a