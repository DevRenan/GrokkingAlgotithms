# frozen_string_literal: true

def binary_search(array, value)
  key = array.size/2
  puts array[key]
  case array[key] <=> value
  when -1
    puts 'Too Low'
    binary_search(array[key+1..array.size-1], value)
  when 1
    puts 'Too High'
    binary_search(array[0..key-1], value)
  else
    value
  end
end


binary_search((0..255).to_a, 9)


