module ParkingLot
  class Service

    attr_accessor :slots

    def initialize()
      @slots = nil
    end

    def create_parking_lot(number)
      @slots = ParkingLot::Slots.new(6)
      return "Created a parking lot with #{@slots.list.count} slots"
    end

    def park(car_number,  color)
      next_available_slot = slots.next_available_slot
      return 'Sorry, parking lot is full.' if  next_available_slot > slots.size
      car = ParkingLot::Car.new(car_number, color)
      slots.list[next_available_slot] = car
      # Need to update the next available parking lot
      return "Allocated slot number: #{next_available_slot}"
    end

    def leave(slot_number)
      slots.list[slot_number] = nil
      slots.next_available_slot = slot_number if slots.next_available_slot > slot_number
    end

    def status
      puts "Slot No Registration No   Color"
      slots.list.each do |k, v|
        puts "#{k}  #{v.car_number}. #{v.color}"
      end
    end

    def registration_numbers_for_cars_with_colour(color)
      cars = slots.list.values.compact
      cars.map{|c| c.car_number if c.color == color }
    end

    def slot_numbers_for_cars_with_colour(color)
      nums = []
      slots.list.each do |k, v|
        num << k if v.color == color
      end
    end

    def slot_number_for_registration_number(car_number)
      slots.list.each do |k, v|
        return k if v.car_number == car_number
      end
    end

  end
end
