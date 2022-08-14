 ## this create heirachy of classes
 ##  class and sub-classes

class Employee
  attr_reader :name, :id

  def initialize(args)
    @name = args[:name]
    @id = args[:id]
  end

  def compute_pay
  end
end
 
class HourlyEmployee < Employee
  attr_reader :commision, :contracts_landed, :pay_rate, :hours_worked, :employer_cost

  def initialize(args)
    super(args)
    @commision = args[:commission] || 100
    @contracts_landed = args[:contracts_landed] 
    @pay_rate = args[:pay_rate]
    @hours_worked = args[:hours_worked]
    @employer_cost = args[:employer_cost] || 1000
  end

  def compute_pay
    pay_rate.to_i * hours_worked.to_i + employer_cost.to_i + commision.to_i * contracts_landed.to_i
  end
end

class SalariedEmployee < Employee
  attr_reader :commision, :contracts_landed, :monthly_salary, :percentage

  def initialize(args)
    super(args)
    @monthly_salary = args[:monthly_salary]
    @percentage = args[:percentage] || 1
  end

  def compute_pay_without_commision
    monthly_salary * percentage
  end
 end

class SalariedEmployeeWithCommission < SalariedEmployee
  attr_reader :commision, :contracts_landed, :monthly_salary, :percentage

  def initialize(args)
    super(args)
    @commision = args[:commission] || 100
    @contracts_landed = args[:contracts_landed]
  end

  def compute_pay
    compute_pay_without_commision + commision * contracts_landed
  end
end

class Freelancer  < Employee
  attr_reader :name, :id, :commision, :contracts_landed, :pay_rate, :hours_worked, :vat_number

  def initialize(args)
    super(args)
    @commision = args[:commission] || 100
    @contracts_landed = args[:contracts_landed]
    @pay_rate = args[:pay_rate]
    @hours_worked = args[:hours_worked]
    @vat_number = args[:vat_number]
  end

  def compute_pay
    pay_rate * hours_worked  + commision * contracts_landed
  end
end

henry = HourlyEmployee.new(:name => "Henry", id: 1, pay_rate: 50, hours_worked: 100)

print "#{henry.name} worked for #{henry.hours_worked} hours and earned $#{henry.compute_pay}"

puts

sarah = SalariedEmployeeWithCommission.new(name: "Sarah", id: 1234, monthly_salary: 5000, contracts_landed: 10)

print "#{sarah.name} landed #{sarah.contracts_landed} contract and earned $#{sarah.compute_pay}"

puts 
