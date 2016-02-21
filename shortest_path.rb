require 'pry'

starting_node    = :a

destination_node = :f

tentative_distance =  { 
  a: 0,
  b: nil,
  c: nil,
  d: nil,
  e: nil,
  f: nil,
  g: nil
}

node_neighboors = {
  a: {b: 4, c: 3, e: 7},
  b: {a: 4, c: 6, d: 5},
  c: {b: 6, a: 3, e: 8, d: 11},
  d: {b: 5, c: 11, e: 2, f: 2, g: 10},
  e: {c: 8, d: 2, g: 5},
  f: {d: 2, g: 3},
  g: {d: 10,e: 5, f: 3}
}

current_node = :a

visted_nodes    = []

unvisited_nodes = [:a, :b, :c, :d, :e, :f, :g]


[:a, :b, :c, :d, :e, :f, :g].each do |u_node|

  # Set current node as visited
  visted_nodes << current_node
  if unvisited_nodes.include?(current_node)
    unvisited_nodes.delete(current_node)
  end
  # Remove from neighboors since it was visited
  node_neighboors.each do |k,v|
    v.delete(current_node) if v[current_node]
  end


  # Calculate distance to unvisited neighboors of current_node
  neighboors = node_neighboors[current_node]

  neighboors.each do |k,v|
    if tentative_distance[k].nil?
      tentative_distance[k] = node_neighboors[current_node][k] + tentative_distance[current_node]
    elsif tentative_distance[k] > (node_neighboors[current_node][k] + tentative_distance[current_node])
      tentative_distance[k] = node_neighboors[current_node][k] + tentative_distance[current_node]
    end
  end

  # Find lowest value for unvisited_nodes in tentative_distance
  unvisited_nodes_with_tentative_distance = {}
  unvisited_nodes.each do |node|
    unless tentative_distance[node].nil?
      unvisited_nodes_with_tentative_distance[node] = tentative_distance[node]
    end
  end
  
  break if current_node == destination_node

  shortest_path = unvisited_nodes_with_tentative_distance.group_by{|k, v| v}.min_by{|k, v| k}.last.to_h
  current_node  = shortest_path.keys.first
end

puts tentative_distance
