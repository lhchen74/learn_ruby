class BaseFoo
    def foo
        private_method
    end

    def private_method
        puts 'come from BaseFoo'
    end

    private :private_method
end

class Foo < BaseFoo
    def bar
        result = foo
        private_method(result)
    end

    def private_method(result = nil)   # private method can overwrite
        puts 'come from Foo'
    end

    private :private_method
end


foo = Foo.new
foo.bar
# come from Foo
# come from Foo