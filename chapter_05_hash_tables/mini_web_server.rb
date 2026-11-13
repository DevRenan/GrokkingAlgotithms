# frozen_string_literal: true

require 'benchmark'

class MiniWebServer
  # 1. Modelando relacionamentos: URL -> Título da Página
  ROTAS = {
    "/" => "Página Inicial",
    "/sobre" => "Sobre Nossa Empresa",
    "/produtos" => "Catálogo de Produtos",
    "/contato" => "Fale Conosco"
  }.freeze

  def initialize
    @cache = {}
    @ips_que_votaram = {}
  end

  # 2. Filtrando duplicatas em O(1)
  def registrar_voto(ip, candidato)
    if @ips_que_votaram[ip].nil?
      @ips_que_votaram[ip] = candidato
    else
      "BLOQUEADO: IP #{ip} já votou!"
    end

  end

  # 3. Caching / Memoization em O(1)
  def buscar_pagina(url)
    # TODO: Verifique se a `url` já existe em `@cache`.
    # Se existir, retorne "[CACHE HIT] #{@cache[url]}"
    # Se NÃO existir:
    #   1. Verifique se a `url` existe em `ROTAS` (se não existir, retorne "404 - Página não encontrada")
    #   2. Simule trabalho pesado do servidor com `sleep(1.5)`
    #   3. Monte o conteúdo: "HTML renderizado de: #{ROTAS[url]}"
    #   4. Salve no `@cache` e retorne "[SERVER RENDER] #{conteudo}"

    if @cache[url]
      "[CACHE HIT] #{@cache[url]}"
    elsif ROTAS[url]
      sleep(1.5)
      conteudo = "HTML renderizado de: #{ROTAS[url]}"
      @cache[url] = conteudo
      "[SERVER RENDER] #{conteudo}"
    else
      "404 - Página não encontrada"
    end
  end
end

# --- TESTES E VALIDAÇÃO ---
server = MiniWebServer.new

puts "=== TESTE 1: FILTRANDO DUPLICATAS (VOTAÇÃO) ==="
puts server.registrar_voto("192.168.0.1", "Ruby")
puts server.registrar_voto("192.168.0.2", "Python")
puts server.registrar_voto("192.168.0.1", "Rust") # Deve ser bloqueado!

puts "\n=== TESTE 2: CACHING DE PÁGINAS ==="
Benchmark.bm(18) do |x|
  x.report("1ª req (/produtos):") { puts " -> #{server.buscar_pagina('/produtos')}" }
  x.report("2ª req (/produtos):") { puts " -> #{server.buscar_pagina('/produtos')}" }
  x.report("1ª req (/sobre):") { puts " -> #{server.buscar_pagina('/sobre')}" }
  x.report("2ª req (/sobre):") { puts " -> #{server.buscar_pagina('/sobre')}" }
  x.report("Req inválida:") { puts " -> #{server.buscar_pagina('/admin')}" }
end