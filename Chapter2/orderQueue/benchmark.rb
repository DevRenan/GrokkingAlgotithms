# frozen_string_literal: true
require 'benchmark'
require_relative 'linked_list_queue'
require_relative 'array_queue'

def test_queue(queue_instance)
  queue_instance.enqueue(1, "Alice")
  queue_instance.enqueue(2, "Bob")
  queue_instance.enqueue(3, "Charlie")

  puts "Próximo pedido (peek): #{queue_instance.peek}"
  puts "Atendendo: #{queue_instance.dequeue}" # Esperado: Alice
  puts "Atendendo: #{queue_instance.dequeue}" # Esperado: Bob

  queue_instance.enqueue(4, "David")
  puts "Atendendo: #{queue_instance.dequeue}" # Esperado: Charlie
  puts "Atendendo: #{queue_instance.dequeue}" # Esperado: David
  puts "Fila vazia? #{queue_instance.empty?}"
end

# puts "--- TESTANDO LINKED LIST QUEUE ---"
# test_queue(LinkedListQueue.new)

# puts "\n--- TESTANDO ARRAY QUEUE ---"
# test_queue(ArrayQueue.new)

# ------------------------------------------------------
# BENCHMARK DE DESEMPENHO (100.000 operações)
# ------------------------------------------------------
N = 1_000_000
Benchmark.bm(20) do |x|
  x.report("LinkedList (dequeue):") do
    ll = LinkedListQueue.new
    N.times { |i| ll.enqueue(i, "User #{i}") }
    N.times { ll.dequeue }
  end

  x.report("Array (shift):") do
    arr = ArrayQueue.new
    N.times { |i| arr.enqueue(i, "User #{i}") }
    N.times { arr.dequeue }
  end
end