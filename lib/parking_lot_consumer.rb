require './lib/service.rb'

# s = ParkingLot::Service.new

# s.create_parking_lot 6
# s.park 'KA-01-HH-1234', 'White'
# s.park 'KA-01-HH-9999', 'White'
# s.park 'KA-01-BB-0001', 'Black'
# s.park 'KA-01-HH-7777', 'Red'
# s.park 'KA-01-HH-2701', 'Blue'
# s.park 'KA-01-HH-3141', 'Black'
# s.leave 4
# s.status
# s.park 'KA-01-P-333', 'White'
# s.park 'DL-12-AA-9999', 'White'
# s.registration_numbers_for_cars_with_colour 'White'
# s.slot_numbers_for_cars_with_colour 'White'
# s.slot_number_for_registration_number 'KA-01-HH-3141'
# s.slot_number_for_registration_number 'MH-04-AY-1111'

module ParkingLot
  class ParkingLotConsumer
    def self.parking_lot_operation(file_path)
      parking_service = ParkingLot::Service.new
      return puts "File not found" unless File.file?(file_path)
        File.open("#{file_path}", "r").each_line do |line|
        ar = line.split(" ")
        params = ar - [ar[0]]
        parking_service.send(ar[0], *params)
      end
    end
  end
end

ParkingLot::ParkingLotConsumer.parking_lot_operation(ARGV[0])
