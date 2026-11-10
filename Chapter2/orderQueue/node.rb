# frozen_string_literal: true

class Node
  attr_accessor :order_id, :customer_name, :next_node

  def initialize(order_id, customer_name, next_node = nil)
    @customer_name = customer_name
    @next_node = next_node
    @order_id = order_id
  end
end
