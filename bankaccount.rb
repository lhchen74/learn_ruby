# Homework: define BankAccount

class BankAccount
    include Comparable
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

    def <=> (other)
        balance <=> other.balance
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


# Comparable
b1 = BankAccount.new(10_000)
b2 = BankAccount.new(20_000)
p b2 > b1

class Bank
    include Enumerable

    attr_reader :accounts 

    def initialize(accounts) 
        @accounts = accounts
    end

    def each
        accounts.each do |account|
            yield account
        end
    end
end

b1 = BankAccount.new(10_000)
b2 = BankAccount.new(20_000)
bank = Bank.new([b1, b2])
bank.each{|e| p e.balance}