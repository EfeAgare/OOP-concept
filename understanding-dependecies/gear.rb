require_relative 'wheel.rb'

class Gear
  attr_reader :chainring, :cog, :wheel 

  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog       = cog
    @wheel      = wheel
  end

  def gear_inches
    # ratio * Wheel.new(rim, tire).diameter
    ratio * wheel.diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

# puts Gear.new(52, 11, 26, 1.5).gear_inches

## reducing dependncies

# Gear expects a ‘Duck’ that knows ‘diameter’

puts Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches
