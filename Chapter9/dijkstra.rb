# frozen_string_literal: true

grafo_a = {
  "START" => { "A" => 5, "B" => 2 },
  "A" => { "C" => 4, "D" => 2 },
  "B" => { "A" => 8, "D" => 7 },
  "C" => { "D" => 6, "FINISH" => 3 },
  "D" => { "FINISH" => 1 },
  "FINISH" => {}
}

grafo_b = {
  "START" => { "A" => 10 },
  "A" => { "B" => 20 },
  "B" => { "C" => 1, "FINISH" => 30 },
  "C" => { "A" => 1 },
  "FINISH" => {}
}

grafo_c = {
  "START" => { "A" => 2, "B" => 2 },
  "A" => { "C" => 2, "FINISH" => 2 },
  "B" => { "A" => 2 },
  "C" => { "B" => -1, "FINISH" => 2 },
  "FINISH" => {}
}

grafo_armadilha = {
  "START" => { "A" => 10, "B" => 1 },
  "A" => { "FINISH" => 1 },
  "B" => { "A" => 2 },
  "FINISH" => {}
}

def dijkstra_attempt1(grafo, inicio, fim)
  explored_nodes = {}
  grafo.each do |parent_key, values|
    values.each do |key, value|
      value_path = explored_nodes[parent_key].to_i + value
      if explored_nodes[key].nil? || explored_nodes[key] > value_path
        explored_nodes[key] = value_path
      end
    end
  end
  explored_nodes
end

def dijkstra(grafo, inicio, fim)
  explored_nodes = grafo.keys.to_h { |k| [k, { predecessor: -1, distance: Float::INFINITY, closed: false }] }
  explored_nodes[inicio] = { predecessor: nil, distance: 0, closed: false }
  while explored_nodes.values.any? { |node| !node[:closed] } do
    current_node, _data = explored_nodes.reject { |_k, node| node[:closed] }.min_by { |_k, node| node[:distance] }
    _data[:closed] = true
    grafo[current_node].each do |_key, _value|
      new_distance = _data[:distance] + _value
      if explored_nodes[_key][:distance] == Float::INFINITY || explored_nodes[_key][:distance] > new_distance
        explored_nodes[_key][:predecessor] = current_node
        explored_nodes[_key][:distance] = new_distance
      end

    end
  end

  explored_nodes[fim]
end

puts dijkstra(grafo_a, "START", "FINISH")
#
puts dijkstra(grafo_b, "START", "FINISH")
#
# puts dijkstra(grafo_c, "START", 0)
#
puts dijkstra(grafo_armadilha, "START", "FINISH")


def dijkstra_gemini(grafo, inicio, fim)
  # Validação contra pesos negativos (Grafo C)
  if grafo.values.any? { |vizinhos| vizinhos.values.any?(&:negative?) }
    raise ArgumentError, "Dijkstra não suporta arestas com pesos negativos"
  end

  nodes = grafo.keys.to_h do |k|
    [k, { predecessor: nil, distance: Float::INFINITY, closed: false }]
  end
  nodes[inicio][:distance] = 0

  while (current_node, data = nodes.reject { |_, n| n[:closed] }.min_by { |_, n| n[:distance] })
    break if data[:distance] == Float::INFINITY || current_node == fim

    data[:closed] = true

    grafo[current_node].each do |neighbor, weight|
      next if nodes[neighbor][:closed]

      new_distance = data[:distance] + weight
      if new_distance < nodes[neighbor][:distance]
        nodes[neighbor][:predecessor] = current_node
        nodes[neighbor][:distance] = new_distance
      end
    end
  end

  nodes[fim][:distance]
end