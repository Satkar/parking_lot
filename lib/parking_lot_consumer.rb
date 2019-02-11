require './lib/service.rb'

class ParkingLotConsumer

  class << self
    attr_accessor :input_file_path, :output_file_path, :parking_service
  end

  def self.iniatiate_parking_lot_service
    @parking_service = ParkingLot::Service.new
  end

  def self.process_input_and_display_result(input)
    output = execute_command(input) unless input == 'exit'
    STDOUT.puts output
  end

  def self.exit_loop?(input)
    %w(exit).include?(input)
  end

  def self.execute_command(input)
    ar = input.split(" ")
    params = ar - [ar[0]]
    output_message = parking_service.send(ar[0], *params)
  end


  def self.detect_file_input(argument)
    return false unless argument
    @input_file_path, @output_file_path = argument.split('>').collect(&:strip)
    return false unless File.exists?(input_file_path) or File.exists?(output_file_path)
    true
  end

  def self.initiate_file_mode
    return puts "File not found" unless File.file?(input_file_path)
    File.open("#{input_file_path}", "r").each_line do |line|
        ar = line.split(" ")
        params = ar - [ar[0]]
        result = parking_service.send(ar[0], *params)
        puts result if result
    end
  end

  def self.initiate_interactive_mode
    begin
      input = STDIN.gets.strip
      process_input_and_display_result(input)
    end until exit_loop?(input)
  end

  def self.run
    iniatiate_parking_lot_service
    files_path_given = detect_file_input(ARGV[0])
    if files_path_given
      initiate_file_mode
    else
      initiate_interactive_mode
    end
  end

end

ParkingLotConsumer.run

