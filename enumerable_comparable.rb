
# p Enumerable.instance_methods
#! search and filter
w = %w[foo bar ca]

p w.all?{|word| word.length >= 3}
p w.any?{|word| word.length >= 3}
p w.none?{|word| word.length == 5}
p w.one?{|word| word.length == 3}

p (1..10).detect{|i| i % 5 == 0 and i % 7 == 0}  # alias find
p (1..100).find{|i| i % 5 == 0 and i % 7 == 0}
p (1..100).find_all{|i| i % 5 == 0 and i % 7 == 0}
p (1..100).find_index{|i| i% 5 == 0 and i % 7 == 0}

a = [1, 2, 3, 4, 5, 0] 
p a.drop(3)
p (1..100).include?(1)
p (1..10).reject{|i| i % 3 == 0}
p (1..10).select{|i| i % 3 == 0} 


#! grouping 
[3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
    .chunk{|n| n.even?}
    .each{|even, arry| p [even, arry]}

p (1..9).group_by{|i| i % 3}
p (1..9).partition{|i| i.even?}

#! iterate
a = ["a", "b", "c"]
a.cycle(2).each{|e| print e}
puts 
(1..10).each_slice(3) {|e| p e}
hash = Hash::new
%w(cat dog people).each_with_index{|item, index| hash[item] = index}
p hash
a.reverse_each{|e| p e}

#! iterate and create new collection
evens = (1..10).each_with_object([]){|i, a| a << i * 2}
p evens
p [1, 2, 3, 4].flat_map{|e| [e, -e]}
p [[1, 2], [3, 4]].flat_map{|e| e + [100]}
p (1..4).map{|x| x ** x}
p (5..10).reduce(:+)
p (5..10).inject{|sum, n| sum + n}
p (5..10).reduce(1, :*)
p (5..10).inject(1) {|product, n| product * n} 
p [1, 3, 0, 2].sort
p (1..10).sort{|a, b| b <=> a}
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p a.zip(b)

#! stats
# count, max, max_by, minmax, minmax_by...
a = %w(albatross dog horse)
p a.minmax_by{|x| x.length}

#! efficiency
def pythagorean_triples
  (1..Float::INFINITY).lazy.flat_map {|z|
    (1..z).flat_map {|x|
      (x..z).select {|y|
        x**2 + y**2 == z**2
      }.map {|y|
        [x, y, z]
      }
    }
  }
end
# show first ten pythagorean triples
p pythagorean_triples.take(10).force # take is lazy, so force is needed
p pythagorean_triples.first(10)      # first is eager
# show pythagorean triples less than 100
p pythagorean_triples.take_while { |*, z| z < 100 }.force

class Person
    include Comparable

    attr_reader :name

    def initialize(name)
        @name = name
    end

    def <=> other
        self.name <=> other.name
    end

end

p1 = Person.new('Andy')
p2 = Person.new('Babb')
p3 = Person.new('Julian')

# p p1 < p2
# p p2.between?(p1, p3)


class People
    include Enumerable

    attr_reader :people

    def initialize(people)
        @people = people
    end

    def each
        raise 'please provide a block!' unless block_given?
        people.each do |person|
            yield person
        end
    end
end


# ps = People.new([p1, p2, p3])
# ps.each{|e| p e}
# ps.each do |e|
#     p e
# end
# p ps.find{|e| e.name == 'Babb'}
# p ps.detect{|e| e.name == 'Babb'}  # detect <=> find