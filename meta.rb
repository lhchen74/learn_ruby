# eval
puts eval "1 + 1"
eval "def foo; puts 'foo'; end"
foo


class Adder
    def initialize(x)
        @x = x
    end

    def method_missing(method_name)
        regex = /^plus(\d+)$/
        if method_name =~ regex
            val = method_name[regex, 1].to_i
            # eval "def #{method_name}; @x + #{val}; end; #{method_name}"
            Adder.class_eval "def #{method_name}; @x + #{val}; end;"
            eval "#{method_name}"
        else
            super
        end
    end
end

adder = Adder.new(10)
p adder.plus10

String.instance_eval "def foo; puts 'instance_eval foo'; end"
String.foo

String.class_eval "def foo; puts 'class_eval foo'; end"
"abc".foo

str = "abc"
str.instance_eval "def foo; puts 'instance_eval on str object'; end"
str.foo
# instance_eval foo
# class_eval foo
# instance_eval on str object
# str.class_eval "def foo; puts 'class_eval on str object'; end"
# undefined method `class_eval' for "abc"


define_method(:foo) {|arg| puts arg}
define_method(:bar) {puts 'bar'}

foo('bar')
bar

[:new, :create, :destroy].each do |name|
    define_method("test_#{name}") do 
        puts name
    end 
end

test_new
test_create
test_destroy

adder = Adder.new(10)
p adder.plus10


class Adder
    def initialize(x)
        @x = x
    end

    def method_missing(method_name)
        regex = /^plus(\d+)$/
        if method_name =~ regex
            val = method_name[regex, 1].to_i
            # define_method is class private method ??
            # private method can not call by object, only call as function
            self.class.send(:define_method, method_name) { @x + v }
            eval "#{method_name}"
        else
            super
        end
    end
end

adder = Adder.new(10)
p adder.plus10