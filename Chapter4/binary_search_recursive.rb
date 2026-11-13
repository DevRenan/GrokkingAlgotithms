# frozen_string_literal: true

def binary_search(array, value)
  middle = array.size.divmod(2).sum - 1 # Array starts with 0

  return value if value == array[middle]

  if value > array[middle]
    binary_search(array[(middle + 1..-1)], value)
  else
    binary_search(array[0..middle - 1], value)
  end

end

random_number = rand(1..100)
puts "O numéro aleatório é: #{random_number}"

puts binary_search((1..100).to_a, random_number)