# frozen_string_literal: true

def binary_search(array, value)
  middle = array.size.divmod(2).sum-1 # Array starts with 0

  if value == array[middle]
    puts array[middle]
    return value
  else
    if value > array[middle]
      puts array[middle]
      binary_search(array[(middle + 1..-1)], value)
    else
      puts array[middle]
      binary_search(array[0..middle - 1], value)
    end
  end
end

random_number = rand(1..100)
puts "O numéro aleatório é: #{random_number}"

binary_search((1..100).to_a, random_number)