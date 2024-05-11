require_relative 'Logger'
require_relative 'User'

class Transaction
    attr_reader :user, :value
  
    def initialize(user, value)
      @user = user
      @value = value
    end
  end
  
  class Bank
    def self.process_transactions(transactions, bank_users,&callback)
      raise "Method #{__method__} is abstract, please override this method"
    end
  end
  

  
  class CBABank < Bank
    def self.process_transactions(transactions,bank_users, &callback)
      transaction_details = transactions.map { |t| "User #{t.user.name} transaction with value #{t.value}" }.join(', ')
      Logger.log_info("Processing Transactions #{transaction_details}...")
  
      transactions.each do |transaction|
        
        begin
          if transaction.user.balance + transaction.value < 0
            raise "Not enough balance"
          elsif !bank_users.include?(transaction.user)
            raise "#{transaction.user.name} not exist in the bank!!"
          else
            transaction.user.balance += transaction.value
            if transaction.user.balance == 0
              Logger.log_warning("#{transaction.user.name} has 0 balance")
            end
            Logger.log_info("User #{transaction.user.name} transaction with value #{transaction.value} succeeded")
            callback.call(true, transaction)
          end
        rescue => e
          Logger.log_error("User #{transaction.user.name} transaction with value #{transaction.value} failed with message #{e.message}")
          callback.call(false, transaction)
        end
      end
    end
  end
  
  callback = Proc.new do |value, transaction|
    if value
      puts "Call endpoint for success of User #{transaction.user.name} transaction with value #{transaction.value}"
    else
      reason = transaction.user.balance + transaction.value < 0 ? "Not enough balance" : "not exist in the bank!!"
      puts "Call endpoint for failure of User #{transaction.user.name} transaction with value #{transaction.value} with reason #{transaction.user.name} #{reason}"
    end
  end




users = [
  User.new("Ali", 200),
  User.new("Peter", 500),
  User.new("Manda", 100)
]

out_side_bank_users = [
  User.new("Menna", 400),
]

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(out_side_bank_users[0], -100)
]

CBABank.process_transactions(transactions, users,&callback)