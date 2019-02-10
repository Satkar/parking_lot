# Representation of a Slot in the system
module ParkingLot
  class Slot

  	attr_accessor :ticket

  	# This method initializes an object of slots class
    # Params:
    # +ticket+:: is a instance of ParkingLot::Ticket class
    # = Example 1
    #   ParkingLot::Slots.new(6, ParkingLot::Car.new('KA-04-MU-9660', 'Red'))
  	def initialize(ticket=nil)
      @ticket = ticket
    end

  end
end
