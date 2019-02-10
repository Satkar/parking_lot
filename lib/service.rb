require './lib/car.rb'
require './lib/slots.rb'

module ParkingLot
  class Service

    attr_accessor :slots

    def initialize()
      @slots = nil
    end

    def create_parking_lot(number)
      @slots = ParkingLot::Slots.new(6)
      puts "Created a parking lot with #{@slots.list.count} slots"
    end

    def park(car_number,  color)
      immidiate_available_slot = slots.closest_available_slot
      return puts 'Sorry, parking lot is full.' unless immidiate_available_slot
      car = ParkingLot::Car.new(car_number, color)
      slots.list[immidiate_available_slot] = car
      puts "Allocated slot number: #{immidiate_available_slot}"
    end

    def leave(slot_number)
      slots.list[slot_number] = nil
      if slots.next_available_slot > slot_number.to_i
        slots.next_available_slot = slot_number.to_i
      else
        slots.closest_available_slot
      end
      puts "Slot number #{slot_number} is free"

    end

    def status
      puts "Slot No Registration No   Color"
      slots.list.each do |k, v|
        if v
          puts "#{k}  #{v.number}. #{v.color}"
        end
      end
    end

    def registration_numbers_for_cars_with_colour(color)
      cars = slots.list.values.compact
      puts cars.map{|c| c.number if c.color == color }.compact.join(', ')
    end

    def slot_numbers_for_cars_with_colour(color)
      nums = []
      slots.list.each do |k, v|
        nums << k if v && v.color == color
      end
      puts nums.join(', ')
    end

    def slot_number_for_registration_number(car_number)
      slots.list.each do |k, v|
        return puts k if v && v.number == car_number
      end
      puts 'Not found'
    end

  end
end
