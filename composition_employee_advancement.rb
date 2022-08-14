 ## We try to seperate out the concept andcombine them in meaning ways
 ## 
 ## 1) Employee with employee data
 ## 2) Employee payment structure (hourly, salaried, freelancer)
 ## 3) Commission based on the number of contract
 ##

# 1
### break down again
class Commission

  def initialize
  end

  def get_payment
  end
end


class ContractCommission < Commission
  
  attr_reader :commision, :contracts_landed

  def initialize(args)
    @commision = args[:commission] || 100
    @contracts_landed = args[:contracts_landed]
  end

  def get_payment
     commision * contracts_landed
  end
end


# 2
class Contract
  def initialize
  end

  def get_payment
  end
end


# 3
class Employee
  attr_reader :name, :id, :contract, :commision

  def initialize(args)
    @name = args[:name]
    @id = args[:id]
    @contract = args[:contract]
    @commision = args[:commision]
  end

  def compute_pay
    if commision.nil?
      contract.get_payment
    else
      contract.get_payment + commision.get_payment
    end
  end
end

class HourlyContract < Contract
  attr_reader  :pay_rate, :hours_worked, :employer_cost

  def initialize(args)
    @pay_rate = args[:pay_rate]
    @hours_worked = args[:hours_worked]
    @employer_cost = args[:employer_cost] || 1000
  end

  def get_payment
    pay_rate * hours_worked + employer_cost
  end
end

class SalariedContract < Employee
  attr_reader :monthly_salary, :percentage

  def initialize(args)
    @monthly_salary = args[:monthly_salary]
    @percentage = args[:percentage] || 1
  end

  def get_payment
    monthly_salary * percentage
  end
end

class FreelancerContract < Contract
  attr_reader :pay_rate, :hours_worked, :vat_number

  def initialize(args)
    @pay_rate = args[:pay_rate]
    @hours_worked = args[:hours_worked]
    @vat_number = args[:vat_number]
  end

  def get_payment
    pay_rate * hours_worked
  end
end


henry_contract = HourlyContract.new(pay_rate: 50, hours_worked: 100)
henry = Employee.new(:name => "Henry", id: 1, contract: henry_contract)

print "#{henry.name} worked for #{henry_contract.hours_worked} hours and earned $#{henry.compute_pay}"

puts

sarah_contract = SalariedContract.new(monthly_salary: 5000)
sarah_commision = ContractCommission.new(contracts_landed: 10)
sarah = Employee.new(name: "Sarah", id: 1234, contract: sarah_contract, commision: sarah_commision)

print "#{sarah.name} landed #{sarah_commision.contracts_landed} contract and earned $#{sarah.compute_pay}"

puts 
