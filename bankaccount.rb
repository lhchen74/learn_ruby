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

    def add(account)
        accounts.push(account)
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


# Using 50 threads to create 200 accounts, and 
# deposite each with a random amounts of money and 
# store them into one file: 'balance.txt'

# each line of balance.txt is account information
# for each account. e.g.
# Time.now.to_s 100
# Time.now_to_s 32


bank = Bank.new([])
File.open('balance.txt', 'a') do |f|
    threads = []
    50.times do |i| 
        threads[i] = Thread.new do 
            4.times do |j|
                account = BankAccount.new()
                account.deposite(rand(100))
                bank.add(account)
                f.puts "#{i} #{Time.now.to_s} #{account.balance}"
                f.flush
            end
        end
    end
    # threads.each{ |t| t.join }
    threads.each(&:join)
end 
bank.each { |e| puts e}