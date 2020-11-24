a = 3
puts a.class
puts a.even?
puts a.to_s
puts 3.222.round(2)

# String is mutable 
a = 'hello, world'
one = a.object_id
a[0] = 'H'
puts a
two = a.object_id
puts one == two
# "" can use interpolation
puts "#{a}"
# %q() '' not use escape
puts %q(I'am a boy.)
# %Q() "" not use escape
puts %Q("What is "Ruby"")

doc = <<-MULTI
hello
world!
MULTI
puts doc

# Symbol is immutable
puts :foo.class  # Symbol


# - normal method: normal method
# - predict method: even? 
# - dangerous method: reverse!

puts "hello".include?('o')
a = "hello"
b = a.sub('h', 'H')
puts a
puts b
b = a.sub!('h', 'H')
puts a
puts b


# Homework
# 1. Determines if a string is palindrome, such as abcba 
# 2. Find all even number location letter in a string, such as "abcd" => "bd"


def palindrome?(str)
    len = str.length
    count = (str.length / 2).floor()
    for i in 0..count
        if str[i] != str[len-i-1] 
            return false
        end
    end
    return true
end

puts palindrome?("abcba")
puts palindrome?("abba")
puts palindrome?("abcb")

def even_letters(str)
    s = ""
    for i in 0...str.length
        if (i + 1) % 2 == 0 
            s += str[i]
        end
    end
    return s
end

puts even_letters("abcd")

