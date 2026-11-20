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
    return "BLOQUEADO: IP #{ip} já votou!" if @ips_que_votaram.key?(ip)
    @ips_que_votaram[ip] ||= candidato
  end

  # 3. Caching / Memoization em O(1)
  def buscar_pagina(url)
    return "404 - Página não encontrada" unless ROTAS.key?(url)
    @cache[url] ||= begin
                      sleep(1.5)
                      "HTML renderizado de: #{ROTAS[url]}"
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