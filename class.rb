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


# Homework: define BankAccount

class BankAccount
    @@exchange_rate = 6 # $ => ￥

    # attr_reader :balance
    def balance
        @balance
    end
    
    def initialize(amount = 0) # balance: 余额
        @balance = amount
    end

    # def self.usd_to_rmb(amount)
    #     amount * @@exchange_rate
    # end

    # def self.rmb_to_usd(amount)
    #     amount / @@exchange_rate
    # end

    class << self
        def usd_to_rmb(amount)
            (amount * @@exchange_rate).round(2)
        end

        def rmb_to_usd(amount)
            (amount / @@exchange_rate).round(2)
        end
    end

    def deposite(amount)
        @balance += amount
    end

    def withdraw(amount)
        @balance -= amount
        raise 'Overdraw Alert' if @balance < 0
    end
end

account = BankAccount.new(100)
p account.balance
account.deposite(100)
account.withdraw(50)
p account.balance

p BankAccount.usd_to_rmb(100)
p BankAccount.rmb_to_usd(100)

class CitiBankAccount < BankAccount
    def transfer(to_account, amount)
        @balance -= amount
        to_account.deposite(amount)
    end

    def withdraw(amount)
        super
        @balance -= 3   # 3 service fee
    end
end 

class ChaseBankAccount < BankAccount
    def withdraw(amount)
        super
        @balance -= 2
    end
end


# module Lib  ???
#     BUCKETS = [0, 1000, 10_000, 50_000, 100_000]
#     FEES = [10, 5, 3, 0, 0]

#     def annual_fee
#         for i in 1..BUCKETS.length - 1
#             if balance < BUCKETS[i]
#                 return FEES[i - 1]
#             end
#         end
#     end
# end

module Lib 
    BUCKETS = [0, 1000, 10_000, 50_000, 100_000]

    def annual_fee
        case balance
        when BUCKETS[0]...BUCKETS[1]
            10
        when BUCKETS[1]...BUCKETS[2]
            5
        when BUCKETS[2]...BUCKETS[3]
            3
        else
            0
        end
    end
end


class BankAccount 
    include Lib
end

b = BankAccount.new(10_000)
p b.annual_fee