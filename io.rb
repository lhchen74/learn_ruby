# File < IO < Object

# parse filename
full_name = '/workspaces/ruby/helper.rb'
p File.basename(full_name)
p File.basename(full_name, '.rb')  # 'helper'
p File.dirname(full_name)  
p File.extname(full_name)  
p File.join('home', 'code')
p File.expand_path('~/ruby')


# navigate and examine directories and files
# p Dir.pwd
# p Dir.chdir('..')
# p Dir.pwd
# p Dir.entries('.')
# p Dir['*.rb']
p File.exists?(full_name)
p File.directory?(full_name)
p File.file?(full_name)
p File.size(full_name)

# iterating file
# p Dir['*.rb']
# Dir.glob('*.rb') {|f| load f}

# manipulating files
# Dir.mkdir('tmp')
# Dir.rmdir('tmp')
# File.rename('test', 'new_test')
# File.delete('test')
# File.symlink('test', 'old_test')

# read and write
# File.open('file_name', 'r') { do_something }
# File.open('file_name', 'w') { do_something }

# begin
#     f = File.open('./note.md')
# rescue
#     puts "This file doesn't exists!"
# ensure
#     f.close if f
# end

# File.open('./note.md', 'r') do |f|
#     while line = f.gets
#         puts line
#     end
# end

# p File.readlines('./note.md')
# p File.read('./note.md')

# write
# File.open('test.txt', 'w') do |f|
#     f << 'hello'
#     f << ' world'
#     f.puts
#     f.puts 'hello'
#     f.puts 'world'
# end 


# Homework
# Create a directory 'Log/' whith 10 log files named log0.txt, log1.txt, ... ,etc. Each of which prints 'hello\n world\n #{file_name}'
# And then read from eatch file, and append them into array

# Dir.mkdir('Log')
# Dir.chdir('Log')
# (0...10).each do |i|
#     file_name = "log#{i}.txt"
#     File.open(file_name, 'w') do |f|
#         f.puts 'hello'
#         f.puts 'world'
#         f.puts file_name
#     end 
# end 

# p Dir['Log/*.txt']
# arr = []
# Dir['Log/*.txt'].each{ |f| arr.push(File.read(f)) }
# p arr


# Dir.mkdir('Log')
# Dir.chdir('Log')
# 10.times.each do |i|
#     file_name = "log#{i}.txt"
#     File.open(file_name, 'w') do |f|
#         f.puts 'hello'
#         f.puts 'world'
#         f.puts file_name
#     end 
# end 


res = Dir.glob('Log/*.txt').each_with_object([]) do |file_name, ret|
    ret.push(*File.readlines(file_name))
end 

puts res

