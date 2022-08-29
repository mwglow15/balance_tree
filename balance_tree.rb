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

  # TODO: Fix case where value already exists
  def insert(value,node=@root)
    if value < node.data
      insert(value,node.left) unless node.left.nil?
      node.left = Node.new(value) if node.left.nil?
    else
      insert(value,node.right) unless node.right.nil?
      node.right = Node.new(value) if node.right.nil?
    end
  end

  def delete(value, node = @root)

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      if node.left.nil?
        temp = node.right
        return temp
      elsif node.right.nil?
        temp = node.left
        return temp
      end

      temp = find_min(node.right)

      node.data = temp.data

      node.right = delete(temp.data, node.right)

    end

    return node
  end

  def level_order(node = @root, queue = [], print_arr = [], &block)
    if block_given?
      print_arr.push(yield node.data) unless node.data.nil?
    else
      print_arr.push(node.data) unless node.data.nil?
    end

    queue.push(node.left) unless node.left.nil?
    queue.push(node.right) unless node.right.nil?


    level_order(queue.shift, queue, print_arr, &block) unless queue.empty?

    return print_arr
  end

  def find_min(node)
    return node if node.left.nil?

    min = find_min(node.left)

    return min
  end

  def find(value, node = @root)
    return node if value == node.data

    if value < node.data
      found_node = find(value,node.left)
    else
      found_node = find(value,node.right)
    end

    return found_node
  end

  def find_parent(value, node = @root, parent = -1)
    return parent if value == node.data
  
      if value < node.data
        parent_node = find_parent(value,node.left, node)
      else
        parent_node = find_parent(value,node.right, node)
      end
  
      return parent_node
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
puts a.pretty_print
p a.level_order
