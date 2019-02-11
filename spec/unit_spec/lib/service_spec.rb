require 'spec_helper'
require "service"

RSpec.describe ParkingLot::Service do

	let(:service) {  ParkingLot::Service.new }
	let(:number) { 6 }

  describe "#create_parking_lot" do

    subject(:create_parking_lot) { service.create_parking_lot(number) }

    it "Should return successfuly parking lot creation message" do
      expect(create_parking_lot).to eq("Created a parking lot with #{number} slots")
    end

  end

  describe "#park" do
  	let(:slots) { service.create_parking_lot(number) }

    subject(:park) do
    	number
    	slots
    	park_cars
    	service.park('KA-01-HH-1234',  'White')
    end

    context "When parking slots are available" do
    	let(:park_cars) do
	  		number.times do |n|
	  			service.slots.list[n+2] = n + 2
	  		end
  		end

	    it "Should return successfuly car parking message" do
	      expect(park).to eq("Allocated slot number: 1")
	    end
	  end

	  context "When parking slots are not available" do
    	let(:park_cars) do
	  		number.times do |n|
	  			service.slots.list[n+1] = n + 1
	  		end
  		end

	    it "Should return parking full messsage" do
	      expect(park).to eq("Sorry, parking lot is full")
	    end
	  end
  end

  describe "#leave" do
  	let(:slots) { service.create_parking_lot(number) }
  	let(:park_cars) do
  		number.times do |n|
  			service.slots.list[n] = n
  		end
		end

		let(:slot_number) { 4 }

  	subject(:leave) do
  		slots
  		park_cars
  		service.leave(4)
  	end

  	it "Should return slot free message" do
	     expect(leave).to eq("Slot number #{slot_number} is free")
	  end
  end

  describe "#registration_numbers_for_cars_with_colour" do
  	let(:slots) { service.create_parking_lot(number) }

  	let(:park_cars) do
  		number.times do |n|
  			service.slots.list[n] = nil
  		end
		end

    let(:park) do
    	slots
    	service.park('KA-01-HH-1234',  'White')
    	service.park('KA-01-HH-1255',  'Red')
    	service.park('KA-01-HH-1236',  'White')
    end

    context "When looking for white color car registration number" do
    	subject(:car_numbers) do
    		park
    		service.registration_numbers_for_cars_with_colour('White')
    	end

	    it " should return KA-01-HH-1234 and KA-01-HH-1236" do
	    	expect(car_numbers).to eq('KA-01-HH-1234, KA-01-HH-1236')
	    end
  	end

  	context "When looking for red color car registration number" do
    	subject(:car_numbers) do
    		park
    		service.registration_numbers_for_cars_with_colour('Red')
    	end

	    it " should return KA-01-HH-1255" do
	    	expect(car_numbers).to eq('KA-01-HH-1255')
	    end
  	end

  	context "When looking for orange color car registration number" do
    	subject(:car_numbers) do
    		park
    		service.registration_numbers_for_cars_with_colour('Orange')
    	end

	    it " should return empty string" do
	    	expect(car_numbers).to eq('')
	    end
  	end
  end

  describe "#slot_numbers_for_cars_with_colour" do
  	let(:slots) { service.create_parking_lot(number) }

  	let(:park_cars) do
  		number.times do |n|
  			service.slots.list[n] = nil
  		end
		end

    let(:park) do
    	slots
    	service.park('KA-01-HH-1234',  'White')
    	service.park('KA-01-HH-1255',  'Red')
    	service.park('KA-01-HH-1236',  'White')
    end

    context "When looking for white color slot number" do
    	subject(:car_numbers) do
    		park
    		service.slot_numbers_for_cars_with_colour('White')
    	end

	    it " should return 1, 3" do
	    	expect(car_numbers).to eq('1, 3')
	    end
  	end
  end


  describe "#slot_number_for_registration_number" do
  	let(:slots) { service.create_parking_lot(number) }

  	let(:park_cars) do
  		number.times do |n|
  			service.slots.list[n] = nil
  		end
		end

    let(:park) do
    	slots
    	service.park('KA-01-HH-1234',  'White')
    	service.park('KA-01-HH-1255',  'Red')
    	service.park('KA-01-HH-1236',  'White')
    end

    describe "When looking for slot number using car number" do
	    context "When car is parked" do
	    	subject(:car_numbers) do
	    		park
	    		service.slot_number_for_registration_number('KA-01-HH-1236')
	    	end

		    it " should return 3" do
		    	expect(car_numbers).to eq(3)
		    end
	  	end

	  	context "When car is not parked" do
	    	subject(:car_numbers) do
	    		park
	    		service.slot_number_for_registration_number('KA-01-HH-1239')
	    	end

		    it " should return Not Found" do
		    	expect(car_numbers).to eq('Not found')
		    end
	  	end
	  end
  end

end
