#Creating a multiplication table with all the elements in the array. So
# if your array is [2, 3, 7, 8, 10], you first multiply every element by 2,
# then multiply every element by 3, then by 7, and so on.

def multiplication_table(array)
  array.each do |element|
    p array.map{|e| e*element}
  end
end

multiplication_table( [2, 3, 7, 8, 10])