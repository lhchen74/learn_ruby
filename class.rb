class Point
    attr_accessor :x
    attr_reader :y

    # @x instance variable, can not access direct
    # @@x class variable, can not access direct
    # $x global variable, ?
    # x local variable
    # X constant, Class::X

    @@origin = 0
    ORIGIN = 0

    def self.get_origin
        @@origin
    end

    def initialize(x = 0, y = 0) 
        @x, @y = x, y
    end

    def first_quadrant?
        x > 0 && y > 0 # self.x > 0 && self.y > 0, instance method self is object, self.x is method  => attr_accessor :x => @x
    end

    def +(p2)
        Point.new(x + p2.x, y + p2.y)
    end

    def self.second_quadrant?(x, y) # class method, self is class
        x < 0 && y > 0 
    end
end

point = Point.new()
p point.x
point.x = 1
p point.x
p point.y
# point.y = 1 # undefined method `y='
p point.first_quadrant?

p point + Point.new(1, 1)

p Point.second_quadrant?(-1, 1)

p Point.get_origin
p Point::ORIGIN
