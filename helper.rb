require "./class.rb"

module Helper
    def self.distance(p1, p2)
        Math.sqrt((p1.x - p2.x) ** 2 + (p1.y - p2.y) ** 2)
    end
    
    
    def shift_right(x, y)
        return x + 1, y  # return multi value must use add return
    end
end

puts "-" * 50

p1 = Point.new(1, 1)
p2 = Point.new(2, 2)
p Helper.distance(p1, p2)

class Point 
    # include: mixin module instance methods as class' instance methods
    include Helper
end

p1 = Point.new(1, 1)
p p1.shift_right(1, 1)


class Point
    # include: mixin module instance methods as class' class methods
    extend Helper
end

p Point.shift_right(1, 1)

module Helper
    def shift_right(x, y)
        return x + 1, y  
    end

    module ClassMethods
        def distance(p1, p2)
            Math.sqrt((p1.x - p2.x) ** 2 + (p1.y - p2.y) ** 2)
        end
    end

    # when included in kclass, the hook is called
    def self.included(kclass)
        kclass.extend ClassMethods
    end
end

class Point 
    include Helper
end

p Point.distance(p1, p2)
p Point.included_modules
p Point.ancestors
p Point.ancestors - Point.included_modules
p Point.is_a? Module