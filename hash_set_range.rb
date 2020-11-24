a = {key: 'value'}
b = a
p a.object_id == a.object_id
a[:key] = 'foo'
p b

h = {a: 3, b: 4}
p h
h = {:a => 3, :b => 4}
p h

h = Hash.new
h = Hash.new(3)
p h # {} ??
p h[0] # 3 ??

h = Hash.new([])
h[:a] << 1
p h[:b]  # 1

h = Hash.new{ |h, k| h[k] = []}
h[:a] << 1
p h[:b] # []

h = {a: 1, b:2}
h.delete(:a)
p h 
p h.assoc(:b) # [:b, 2]
p h.empty?()
p h.empty?
p h.has_value?(2)
p h.has_value?(:b)
p h.keys
p h.values
p h.to_a # [[:b, 2]]
h2 = {d: 4}
h = h.merge(h2)
p h


h.each{|k, v| p [k, v]}
h.each_key{|k| p k}
h.each_value{|v| p v}
p h.select{|k| k == :d}

require 'set'
a = Set.new [1, 2]
p a
b = Set.new [1, 2, 4]
p a & b
p a | b
p a <= b  # a is sub set of b


p 1..3   # close range
p 1...3  # open range

# Homework 
# How to solve the problem that switch symbol and string key of hash?
