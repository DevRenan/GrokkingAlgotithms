# frozen_string_literal: true

# Representação de um sistema de arquivos mockado:
# - Números representam o tamanho dos arquivos em bytes.
# - Hashes representam diretórios que contêm arquivos ou outros diretórios.
meu_sistema_de_arquivos = {
  "foto_perfil.png" => 1200,
  "documentos" => {
    "relatorio.pdf" => 3500,
    "notas.txt" => 400,
    "trabalho" => {
      "planilha.xlsx" => 8000,
      "apresentacao.pptx" => 15000
    }
  },
  "musica.mp3" => 5000
}

def tamanho_total(node)
  # TODO: Implemente a lógica recursiva aqui
  # Dica: `node.is_a?(Numeric)` ou `node.is_a?(Hash)` ajuda a identificar o tipo!
  total = 0
  node.each_value do |value|
    if value.is_a?(Numeric)
      total += value
    elsif value.is_a?(Hash)
      total+= tamanho_total(value)
    end
  end
  total
end


# Teste e Validação
total = tamanho_total(meu_sistema_de_arquivos)

puts "Tamanho total do diretório: #{total} bytes"
# O resultado esperado é: 33100 bytes (1200 + 3500 + 400 + 8000 + 15000 + 5000)
