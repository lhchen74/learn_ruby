a = []
b = a
puts a.object_id
puts b.object_id
a << 'foo'
puts b

a = Array.new
a = Array.new(3)
a = Array.new(3, 0)
puts a

a = Array.new(3, "abc")
puts a[0].object_id == a[1].object_id # true

a = Array.new(3) {"abc"}
puts a[0].object_id == a[1].object_id # false

a = %w(foo bar fo ba)
print a # ["foo", "bar", "fo", "ba"]
puts
puts a.fetch(5, "aaa")
puts a[1..2]
a.push("bar")
p a.uniq

a = [1, 2, 3, -4, -5]
a.each{|e| p e}
a.reverse_each{|e| p e}
a.each_with_index{|e, i| p [e, i]} 
a.sort!
p a.select{|e| e > 0}
a << nil
p a.compact
p a.compact!
p a.compact!  # if no effect, return nil 
p a.any? {|e| e > 5}


# Homework
# input = [1, 2, 3], output = [2, 4, 6]
output = []
input = [1, 2, 3]
input.each{|e| output << e * 2}
p output

output = input.map{|e| e * 2}
p output