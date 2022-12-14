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

  def preorder(node = @root, print_arr = [], &block)
    if block_given?
      print_arr.push(yield node.data)
    else
      print_arr.push(node.data)
    end
    print_arr.push(preorder(node.left, &block)) unless node.left.nil?
    print_arr.push(preorder(node.right, &block)) unless node.right.nil?

    print_arr.flatten
  end

  def inorder(node = @root, print_arr = [], &block)
    print_arr.push(inorder(node.left, &block)) unless node.left.nil?
    if block_given?
      print_arr.push(yield node.data)
    else
      print_arr.push(node.data)
    end
    print_arr.push(inorder(node.right, &block)) unless node.right.nil?

    print_arr.flatten
  end

  def postorder(node = @root, print_arr = [], &block)
    print_arr.push(postorder(node.left, &block)) unless node.left.nil?
    print_arr.push(postorder(node.right, &block)) unless node.right.nil?
    if block_given?
      print_arr.push(yield node.data)
    else
      print_arr.push(node.data)
    end

    print_arr.flatten
  end

  def find_min(node)
    return node if node.left.nil?

    min = find_min(node.left)

    return min
  end

  def find(value, node = @root)
    return node if value == node.data

    if value < node.data
      found_node = find(value, node.left)
    else
      found_node = find(value, node.right)
    end

    return found_node
  end

  def find_parent(value, node = @root, parent = -1)
    return parent if value == node.data

    if value < node.data
      parent_node = find_parent(value, node.left, node)
    else
      parent_node = find_parent(value, node.right, node)
    end

    return parent_node
  end

  def height(node)
    height_left, height_right = 0,0

    return 0 if node.nil?
    return 0 if node.left.nil? && node.right.nil?

    if node.left
      height_left = 1
      height_left += height(node.left)
    end

    if node.right
      height_right = 1
      height_right += height(node.right)
    end

    return [height_left, height_right].max
  end

  def depth(node, root = @root)
    depth = 0
    if node.data < root.data
      depth = 1
      depth += depth(node, root.left) unless root.left.nil?
    elsif node.data > root.data
      depth = 1
      depth += depth(node, root.right) unless root.right.nil?
    end

    return depth
  end

  def balanced_height(root = @root)
    return 0 if root.nil?

    left_tree_height = balanced_height(root.left)
    #puts "node: #{root.data} - left height: #{left_tree_height}"
    return -1 if left_tree_height == -1

    right_tree_height = balanced_height(root.right)
    #puts "node: #{root.data} - right height: #{right_tree_height}"
    return -1 if right_tree_height == -1

    return -1 if (left_tree_height - right_tree_height).abs > 1

    return ([left_tree_height, right_tree_height].max + 1)
  end

  def balanced?
    balanced_height != -1
  end

  def rebalance
    arr = level_order

    @root = build_tree(arr)
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

a = Tree.new(Array.new(15) { rand(1..100)})
a.pretty_print
p a.balanced?
p a.level_order
p a.preorder
p a.postorder
p a.inorder
a.insert(150)
a.insert(105)
a.insert(175)
a.insert(120)
a.pretty_print
p a.balanced?
a.rebalance
a.pretty_print
p a.balanced?