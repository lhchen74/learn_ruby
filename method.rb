str = "Hello"
def str.foo   # singleton method
    p self
end

str.foo  # "Hello"

def foo
    p "foo"
end

alias :bar :foo
bar

arr = [1, 2, 3]
p arr + [4]
p arr
# p arr + 4 # `+': no implicit conversion of Fixnum into Array 
def arr.+(num) 
    self.dup << num   # self.dup duplicate self
end
p arr + 4

def star(a, *b, c) 
    p a
    p b
    p c
end

star(1, 2, 3, 4, 5)

def hash_parameter(h)
    h.each do |k, v|
        p k, v
    end
end

hash_parameter(a: 3, b: 4)
hash_parameter({a: 3, b: 4})


def sum(a, b)
    a + b
end

p sum 3, 3

 
# Homework 
# Use singleton method transfer [1, 2, 3] it self to [2, 4, 6]

arr = [1, 2, 3]
def arr.*(num)
    self.map{|e| e * 2}
end

p arr * 2
