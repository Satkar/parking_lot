# Representation of a Slot in the system
module ParkingLot
  class Slots

  	attr_accessor :list, :size, :next_available_slot

  	# This method initializes an object of slots class
    # Params:
    # +number+:: 'integer' is a number of slots to be created
    # = Example 1
    #   ParkingLot::Slots.new(6)
  	def initialize(number)
  		@list = {}
  		1.upto(number) do |i|
      	@list[i] = nil
    	end
    	@size = number
    	@next_available_slot = 1
    end

    def closest_available_slot
    	self.list.each do |slot, car|
    		return self.next_available_slot = slot unless car
    	end
    	nil
    end

  end
end
