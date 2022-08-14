class Bicycle
  attr_reader :size, :chain, :tire_size
  def initialize(args={})
  @size = args[:size]
  @chain = args[:chain] || default_chain 
  @tire_size = args[:tire_size] || default_tire_size

  post_initialize(args)
  end

  # subclasses may override
   def post_initialize(args) # and implements this 
    nil
   end

  def default_chain 
    '10-speed'
  end 

  def default_tire_size 
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end

  def spares
{ tire_size: tire_size,
            chain:     chain}.merge(local_spares)
  end

  # hook for subclasses to override
  def local_spares 
    {}

  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(args) # RoadBike can 
    @tape_color = args[:tape_color] # optionally # override it
  end

  def default_tire_size 
    '23'
  end 

  def local_spares 
    {tape_color: tape_color}
  end
end

# <- common default
# <- subclass default
class MountainBike < Bicycle 
  attr_reader :front_shock, :rear_shock

  def post_initialize(args) 
    @front_shock = args[:front_shock] 
    @rear_shock = args[:rear_shock]
  end

  def local_spares 
    {rear_shock: rear_shock}
  end

  def default_tire_size # <- subclass default 
    '2.1'
  end 
end


road_bike = RoadBike.new(size: 'M', tape_color: 'red' )

puts road_bike.tire_size     # => '23'
puts road_bike.chain 

mountain_bike = MountainBike.new( size: 'S', front_shock:  'Manitou', rear_shock:   'Fox')

puts  mountain_bike.tire_size # => '2.1'
puts road_bike.chain 


class RecumbentBike < Bicycle 
  attr_reader :flag

  def post_initialize(args) 
    @flag = args[:flag]
  end

  def local_spares 
    {flag: flag}
  end

  def default_chain 
    "9-speed"
  end

  def default_tire_size 
    '28'
  end 
end

bent = RecumbentBike.new(flag: 'tall and orange') 
puts bent.spares
# -> {:tire_size => "28",
      #     :chain     => "9-speed",
      #     :flag      => "tall and orange"}