# frozen_string_literal: true

#4.3 Write a recursive function to find the maximum number in a list.

def recursive_max_list(list)
  return nil if list.empty?
  return list.first if list.size == 1

  sub_max = recursive_max_list(list[1..-1])
  list.first > sub_max ? list.first : sub_max
end

puts recursive_max_list([1, 2, 3, 4, 5, 6,4,1024,80-10,-20,-30])


# 4.2 Write a recursive function to count the number of items in a list.
def recursive_sum_list(list)
  if list.empty?
    0
  elsif list.size == 1
    list.first
  else
    list.shift + recursive_sum_list(list)
  end
end
puts recursive_sum_list([1, 2, 3, 4, 5, 6])

# 4.1 - Write out the code for the earlier sum function.

def sum_list(list)
  sum = 0
  for l in list
    sum += l
  end
  sum
end

puts sum_list([1, 2, 3, 4, 5, 6])

