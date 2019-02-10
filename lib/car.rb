# Representation of a car in the system
module ParkingLot
  class Car

    attr_accessor :number, :color

    # This method initializes an object of car class
    # Params:
    # +number+:: 'string' is a car number
    # +color+:: 'string' is color of car
    # = Example 1
    #   ParkingLot::Car.new('KA-04-MU-9660', 'Red')
    def initialize(number, color)
      @number = number
      @color = color
    end

  end
end
