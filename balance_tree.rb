def class Tree

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    
  end

end

def class Node
  attr_accessor :data, :left_node, :right_node

  def initialize(data)
    @data = data
    @left_node = nil
    @right_node = nil
  end
end