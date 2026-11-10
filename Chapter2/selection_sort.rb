# frozen_string_literal: true

# Cada artista é representado por um Hash com :nome e :plays
playlist = [
  { nome: "Radiohead", plays: 156 },
  { nome: "Kishore Kumar", plays: 141 },
  { nome: "The Black Keys", plays: 35 },
  { nome: "Neutral Milk Hotel", plays: 94 },
  { nome: "Beck", plays: 88 }
]

# 1. Encontra o índice do elemento com MAIOR número de plays
def busca_maior(lista)
  # TODO: Implemente a busca pelo maior valor e retorne o seu ÍNDICE
  # Não utilize o método .max do Ruby!

  biggest_index = 0
  lista.each_with_index do |item, index|
    biggest_index = index if lista[biggest_index][:plays] < item[:plays]
  end
  biggest_index
end

# 2. Ordena a playlist usando Selection Sort (do mais tocado ao menos tocado)
def selection_sort(lista)
  # Trabalhamos com uma cópia para não alterar a lista original diretamente
  copia_lista = lista.dup
  nova_lista = []
  # TODO: Implemente o loop do Selection Sort usando `busca_maior` e `Array#delete_at`
  nova_lista << copia_lista.delete_at(busca_maior(copia_lista)) until copia_lista.empty?
  nova_lista
end

# Execução e validação
playlist_ordenada = selection_sort(playlist)

puts "--- PLAYLIST ORDENADA (Mais tocados) ---"
playlist_ordenada.each_with_index do |artista, i|
  puts "#{i + 1}. #{artista[:nome]} - #{artista[:plays]} reproduções"
end