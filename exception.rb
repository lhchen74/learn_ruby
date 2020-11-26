def foo
    raise 'error msg'
end

# foo # exception.rb:2:in `foo': error msg (RuntimeError)

def foo
    raise ArgumentError, 'error msg'
end

# foo # exception.rb:8:in `foo': error msg (ArgumentError)

def foo
    begin
        raise TypeError, 'error msg', caller
    rescue => e
        puts e.send(:caller)
    end
end

# foo
# exception.rb:13:in `foo'
# exception.rb:21:in `<main>'

def factorial(n)
    raise TypeError unless n.is_a? Integer
    raise ArgumentError if n < 1
    return 1 if n == 1
    n * factorial(n - 1)
end

# begin
#     x = factorial('a')
# rescue TypeError => e
#     puts 'n must be an integer'
# rescue ArgumentError => e 
#     puts 'n must greater equal than 1'
# else
#     puts x
# ensure
#     puts 'factorial completed!'
# end


def boom
    raise 'boom' if rand(3) == 0  # raise message direct will occur RuntimeError
end

def explode
    begin 
        boom
    rescue ArgumentError => e
        puts e
    end
    "hello world"
end

def defuse 
    begin
        puts explode
    rescue RuntimeError => e
        puts e.class
        puts e.message
    end
end

# defuse


# Homework
arr = [1, 2, "abc", 3, "hello", " world", "abc", 0.3]
def sum_pair(arr)
    i = 0
    sum = 0
    while i <= arr.length - 2
        begin
            puts arr[i] + arr[i + 1]
        rescue TypeError => e
            puts e.message
        ensure
            sum += 1
        end
        i += 2
    end
    puts '**! Altogther there are #{sum} pairs processed !**'
end
sum_pair(arr)

def sum_pair(arr)
    sum = 0
    arr.each_slice(2) do |pair|
        begin
            puts pair[0] + pair[1]
        rescue TypeError => e
            puts "Invalid sumation of #{pair[0].class} + #{pair[1].class}"
        else
            sum += 1
        ensure
            
        end
    end

    puts '**! Altogther there are #{sum} pairs processed !**'
end

sum_pair(arr)