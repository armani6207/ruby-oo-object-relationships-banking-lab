require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  
  @@completed = []
  
  def initialize(sender, reciever, amount)
    #binding.pry
    @sender = sender
    @receiver = reciever
    @status = "pending"
    @amount = amount
  end

  def valid?
    if @sender.valid? && @receiver.valid?
      true
    else
      false
    end
  end

  def execute_transaction
    #binding.pry
    if (valid?) && (!@@completed.include?(self)) && (@sender.balance > @amount)
      @sender.balance=(@sender.balance - @amount)
      @receiver.balance=(@receiver.balance + @amount)
      @@completed << self
      @status = "complete"
    else
      @@completed << self
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.balance=(@sender.balance + @amount)
      @receiver.balance=(@receiver.balance - @amount)
      @status = "reversed"
    else
      "could not reverse."
    end
  end

end
