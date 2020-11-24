# 1. using yield
def foo
    a = 2
    yield a
end

foo {|a| p a}

# 2. using & and call
def foo(&block)
    a = 2
    block.call(a)
end

foo {|a| p a}

# block best practice 
# 1. multi line use do ... end, one line use {}
arr = [1, 2, 3]
arr.each do |e|
    p e
    p e
end
arr.each {|e| p e}
# 2. {} has high priority than do...end
# scope is method name, here `:foo` and `lambda {}` are params of method scope
# if use do ... end, `:foo` and `lambda` will as method params, {} as last block
# scope :foo, lambda {|e| 
#     p e
#     p e
# }


def foo
    a = 2
    yield a
end

# foo {|b| p b; p a}  # `block in <main>': undefined local variable or method `a'
a = 2
foo {|b| p b; p a}  # block can access current scope

# bock flow control 
# `block return` is return out the method include bock
# break, next ...
# foo {|b| p b; return} # block_proc_lambda.rb:45:in `block in <main>': unexpected return (LocalJumpError)

def bar 
    x = 3
    yield 3
    p 'end of bar'
end

def foo
    p 'start of foo'
    bar {|x| return if x > 0}
    p 'end of foo'
end

foo  # "start of foo"


# Proc is class
# A Proc object represents block
# Both proc and lambda are Proc object

arr = %w(a b c)
p arr
p arr.map{|x| x.capitalize}
p arr.map(&:capitalize) # method => proc => block, method automate transfer to proc, & transfer proc to block
proc = Proc.new{|x| x * 2}
p proc.class    # Proc
p arr.map(&proc)
lambda = lambda {|x| x * 2}
p lambda.class  # Proc
p arr.map(&lambda)


# Difference between proc and block
# 1. parameters
p = Proc.new{|x, y| p x, y}
p.call(1)
p.call(1, 2)
p.call(1, 2, 3)
# 1
# nil
# 1
# 2
# 1
# 2

l = lambda {|x, y| p x, y}
# l.call(1)  # block_proc_lambda.rb:92:in `block in <main>': wrong number of arguments (given 1, expected 2) (ArgumentError)
l.call(1, 2)
# l.call(1, 2, 3) # block_proc_lambda.rb:92:in `block in <main>': wrong number of arguments (given 3, expected 2) (ArgumentError)

# 2: flow control
p = Proc.new {|x| return if x > 0}
# p.call(1)   # block_proc_lambda.rb:98:in `block in <main>': unexpected return (LocalJumpError)

l = lambda {|x| return if x > 0}
l.call(1)

# Summary: proc behaves more like a block , while lambda behaves more like a method


# Homework: Create a method each_starts_with, which can work like this:
# each_starts_with(["abcd", "axyz", "able", "xyzab"], "ab") {|s| puts s}
# abcd
# able

# def each_starts_with(arr, str)
#     arr.each { |e| yield e if e.start_with?(str) }
# end

def each_starts_with(arr, str, &block)
    arr.each { |e| block.call(e) if e.start_with?(str) }
end

each_starts_with(["abcd", "axyz", "able", "xyzab"], "ab") {|s| puts s}


    
