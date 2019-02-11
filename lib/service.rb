require './lib/car.rb'
require './lib/slots.rb'

module ParkingLot
  class Service

    attr_accessor :slots

    def initialize()
      @slots = nil
    end

    # This method creates a new parking slots
    # Params:
    # +number+:: `integer` number of slots to be created in a parking
    # = Example 1
    #   ParkingLot::Service.new.create_parking_lot(number)
    # => "Created a parking lot with #{number} slots"
    def create_parking_lot(number)
      @slots = ParkingLot::Slots.new(6)
      message = "Created a parking lot with #{@slots.list.count} slots"
      puts message
      message
    end

    # This method  parks a car in a slot
    # Params:
    # +car_number+:: `integer` car number
    # = Example 1
    #   ParkingLot::Service.new.park('KA-01-HH-1234', 'white')
    # if Car geta parked successfully
    # => "Allocated slot number: #{immidiate_available_slot}"
    # else
    # => 'Sorry, parking lot is full.'
    def park(car_number,  color)
      immidiate_available_slot = slots.closest_available_slot

      unless immidiate_available_slot
        parking_full = 'Sorry, parking lot is full.'
        puts parking_full
        return parking_full
      end

      car = ParkingLot::Car.new(car_number, color)
      slots.list[immidiate_available_slot] = car
      message = "Allocated slot number: #{immidiate_available_slot}"
      puts message
      message
    end

    # This method makes the perticular parking slot free
    # Params:
    # +slot_number+:: `integer` car number
    # = Example 1
    #   ParkingLot::Service.new.leave(4)
    # => "Slot number 4 is free"
    def leave(slot_number)
      slots.list[slot_number] = nil
      if slots.next_available_slot > slot_number.to_i
        slots.next_available_slot = slot_number.to_i
      else
        slots.closest_available_slot
      end
      message = "Slot number #{slot_number} is free"
      puts message
      message
    end

    # This method returns the status parked cars
    def status
      puts "Slot No Registration No  Color"
      slots.list.each do |k, v|
        if v
          puts "#{k}  #{v.number} #{v.color}"
        end
      end
    end

    # This method returns registration number of cars whith specific color
    # Params:
    # +color+:: `string` car color
    # = Example 1
    #   ParkingLot::Service.new.registration_numbers_for_cars_with_colour('White')
    # => ""
    def registration_numbers_for_cars_with_colour(color)
      cars = slots.list.values.compact
      list = cars.map{|c| c.number if c.color == color }.compact.join(', ')
      puts cars.map{|c| c.number if c.color == color }.compact.join(', ')
      list
    end

    # This method returns slot numbers of cars whith specific color
    # Params:
    # +color+:: `string` car color
    # = Example 1
    #   ParkingLot::Service.new.slot_numbers_for_cars_with_colour('White')
    # => ""
    def slot_numbers_for_cars_with_colour(color)
      nums = []
      slots.list.each do |k, v|
        nums << k if v && v.color == color
      end
      list = nums.join(', ')
      puts list
      list
    end

    # This method returns slot numbers of cars whith specific registration number
    # Params:
    # +car_number+:: `string` car number
    # = Example 1
    #   ParkingLot::Service.new.slot_number_for_registration_number('KA-01-HH-1255')
    # if car is parked
    # => 3
    # else
    # => 'Not found'
    def slot_number_for_registration_number(car_number)
      slots.list.each do |k, v|
        if v && v.number == car_number
          puts k
          return k
        end
      end
      message = 'Not found'
      puts message
      message
    end

  end
end
