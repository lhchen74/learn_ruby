# def foo
#     10.times { puts "Call foo at #{Time.now}"}
#     sleep(0.5)
# end


# def bar
#     10.times { puts "Call bar at #{Time.now}"}
#     sleep(0.5)
# end

# t1 = Thread.new {foo()}
# t2 = Thread.new {bar()}

# t1.join
# t2.join


# Thread.current hash

# count = 0
# arr = []

# 10.times do |i|
#     arr[i] = Thread.new {
#         sleep(rand(0) / 10.0) # Calling rand(0) is similar to calling rand(). You will get random numbers between 0.0 and 1.0 (not inclusive).
#         Thread.current["count"] = count
#         count += 1
#     }
# end

# arr.each {|t| t.join; print t["count"], ", "}
# puts "count = #{count}"


# Thread priority
# count1 = count2 = 0
# a = Thread.new do
#     loop {count1 += 1}
# end
# a.priority = 1

# b = Thread.new do 
#     loop {count2 += 1}
# end
# b.priority = -1

# sleep 1
# puts count1, count2


# Thread exception
# t1 = Thread.new do
#     puts "In new thread"
#     raise "Exception from thread"
# end

# t1.join

# puts "not reached"

# In new thread
# #<Thread:0x0000556e167c4668 thread.rb:52 run> terminated with exception (report_on_exception is true):
# Traceback (most recent call last):
# thread.rb:54:in `block in <main>': Exception from thread (RuntimeError)
# Traceback (most recent call last):
# thread.rb:54:in `block in <main>': Exception from thread (RuntimeError)


# t1 = Thread.new do
#     puts "In new thread"
#     raise "Exception from thread"
# end

# sleep 1

# puts "not reached"
# In new thread
# #<Thread:0x000055c92c6f4370 thread.rb:70 run> terminated with exception (report_on_exception is true):
# Traceback (most recent call last):
# thread.rb:72:in `block in <main>': Exception from thread (RuntimeError)
# not reached


# Any thread raise exception, other thread exit
# Thread.abort_on_exception = true

# t1 = Thread.new do
#     puts "In new thread"
#     raise "Exception from thread"
# end

# sleep 1

# puts "not reached"

# In new thread
# #<Thread:0x0000562f335b28a0 thread.rb:87 run> terminated with exception (report_on_exception is true):
# Traceback (most recent call last):
# thread.rb:89:in `block in <main>': Exception from thread (RuntimeError)
# Traceback (most recent call last):
# thread.rb:89:in `block in <main>': Exception from thread (RuntimeError)


# Mutex
# count1 = count2 = 0
# difference = 0

# counter = Thread.new do 
#     loop do 
#         count1 += 1
#         count2 += 1
#     end
# end

# diff = Thread.new do 
#     loop do
#         difference += (count1 - count2).abs
#     end
# end

# sleep 2
# puts "count1: #{count1}"
# puts "count2: #{count2}"
# puts "difference: #{difference}"

# count1: 9404541
# count2: 10274349
# difference: 0  # GIL, trully muti-thread use jruby ?? why always 0



mutex = Mutex.new

count1 = count2 = 0
difference = 0

counter = Thread.new do 
    loop do
        mutex.synchronize do 
            count1 += 1
            count2 += 1
        end
    end
end

diff = Thread.new do 
    loop do
        mutex.synchronize do
            difference += (count1 - count2).abs
        end
    end
end

sleep 1
mutex.lock
puts "count1: #{count1}"
puts "count2: #{count2}"
puts "difference: #{difference}"
# count1: 7249430
# count2: 7249430
# difference: 0

