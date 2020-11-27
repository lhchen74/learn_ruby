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
count1 = count2 = 0
a = Thread.new do
    loop {count1 += 1}
end
a.priority = 1

b = Thread.new do 
    loop {count2 += 1}
end
b.priority = -1

sleep 1
puts count1, count2