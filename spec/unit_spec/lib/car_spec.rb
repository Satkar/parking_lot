require 'spec_helper'
require "car"

RSpec.describe ParkingLot::Car do

  describe ".initialize" do
    let(:number) { 'KA-01-HH-1234' }
    let(:color) { 'White' }
    subject(:car) { ParkingLot::Car.new(number, color) }

    it "Should return an object of car object" do
      expect(car.number).to eq(number)
      expect(car.color).to eq(color)
    end

  end
end
