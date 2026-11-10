# frozen_string_literal: true
require_relative 'node'
class ArrayQueue
  attr_reader :array, :head, :tail
  def initialize
    @array = []
    @head = nil
    @tail = nil
  end

  def enqueue(order_id, customer_name)
    @array << Node.new(order_id, customer_name)
    @head = @array.first
    @tail = @array.last
  end

  def dequeue
    @array.shift
  end

  def peek
    @head
  end

  def empty?
    @array.empty?
  end
end
