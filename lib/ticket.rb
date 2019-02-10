# Representation of a ticket in the system
module ParkingLot
  class Ticket

    attr_accessor :car, :parking_slot_number

    # This method initializes an object of ticket class
    # Params:
    # +car+:: car object
    # +parking_slot_number+:: 'integer' is a parking slot number
    # = Example 1
    #   ParkingLot::Ticket.new(ParkingLot::Car.new('KA-04-MU-9660', 'Red'), 1)
    def initialize(car, parking_slot_number)
      @car = car
      @parking_slot_number = parking_slot_number
    end

  end
end
