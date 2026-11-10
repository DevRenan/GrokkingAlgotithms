# frozen_string_literal: true
require_relative 'node'
class LinkedListQueue
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def enqueue(order_id, customer_name)
    if @head.nil?
      @head = Node.new(order_id, customer_name)
      @tail = @head
      return
    end

    current = @tail
    current.next_node = Node.new(order_id, customer_name)
    @tail = current.next_node
  end

  def dequeue
    @head = @head.next_node
  end

  def peek
    @head
  end

  def empty?
    @head.nil?
  end
end
