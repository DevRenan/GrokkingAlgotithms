# frozen_string_literal: true

# Grafo não-direcionado representando as conexões entre estações de metrô
# Note que existem ciclos (ex: Central <-> Luz <-> República <-> Central)
# e uma estação isolada ("Ilha") sem conexão com o resto da rede.
mapa_metro = {
  "Central" => ["Luz", "República", "Sé"],
  "Luz" => ["Central", "República", "Tiradentes"],
  "República" => ["Central", "Luz", "Paulista"],
  "Sé" => ["Central", "Paraíso"],
  "Tiradentes" => ["Luz", "Santana"],
  "Paulista" => ["República", "Paraíso", "Consolação"],
  "Paraíso" => ["Sé", "Paulista", "Vila Mariana"],
  "Santana" => ["Tiradentes", "Tucuruvi"],
  "Consolação" => ["Paulista"],
  "Vila Mariana" => ["Paraíso", "Aeroporto"],
  "Tucuruvi" => ["Santana"],
  "Aeroporto" => ["Vila Mariana"],
  "Ilha" => [] # Estação isolada
}

def existe_caminho?(grafo, origem, destino)
  stations_queue = grafo[origem].dup
  stations_queue_visited = Set.new
  stations_queue.each do |station|
    return true if station == destino
    next if stations_queue_visited.include?(station)

    stations_queue.concat grafo[station]
    stations_queue_visited << station
  end
  return false
end

# PARTE 2 (BÔNUS): Retorna um Array com a sequência do menor caminho (ex: ["Central", "Sé", ...])
def menor_caminho(grafo, origem, destino)
  fila = [[origem]]
  visitados = { origem => true }

  until fila.empty?
    caminho_atual = fila.shift
    estacao_atual = caminho_atual.last

    return caminho_atual if estacao_atual == destino

    grafo[estacao_atual].each do |vizinho|
      next if visitados.key?(vizinho)
      visitados[vizinho] = true

      fila.push(caminho_atual+[vizinho])
    end
  end
  nil
end

# --- TESTES E VALIDAÇÃO ---
puts "=== TESTE 1: EXISTE CAMINHO? ==="
puts "Central -> Aeroporto: #{existe_caminho?(mapa_metro, 'Central', 'Aeroporto')}" # Esperado: true
puts "Central -> Ilha:      #{existe_caminho?(mapa_metro, 'Central', 'Ilha')}"      # Esperado: false

puts "\n=== TESTE 2: MENOR CAMINHO (MENOS ESTAÇÕES) ==="
rota1 = menor_caminho(mapa_metro, "Central", "Aeroporto")
puts "Central -> Aeroporto: #{rota1 ? rota1.join(' -> ') : 'Sem rota'}"
# Esperado: Central -> Sé -> Paraíso -> Vila Mariana -> Aeroporto (4 trechos)

rota2 = menor_caminho(mapa_metro, "Consolação", "Tucuruvi")
puts "Consolação -> Tucuruvi: #{rota2 ? rota2.join(' -> ') : 'Sem rota'}"
# Esperado: Consolação -> Paulista -> República -> Luz -> Tiradentes -> Santana -> Tucuruvi

rota3 = menor_caminho(mapa_metro, "Central", "Ilha")
puts "Central -> Ilha: #{rota3 ? rota3.join(' -> ') : 'Sem rota'}"
# Esperado: Sem rota