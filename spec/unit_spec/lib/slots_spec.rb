require 'spec_helper'
require "slots"

RSpec.describe ParkingLot::Slots do

  describe ".initialize" do
    let(:number) { 6 }
    subject(:slots) { ParkingLot::Slots.new(number) }

    it "Should return an object of slots" do
      expect(slots).not_to be_nil
      expect(slots.list.count).to eq(number)
      expect(slots.next_available_slot).to eq(1)
    end

  end

  describe "#closest_available_slot" do
    let(:number) { 6 }
    let(:slots) { ParkingLot::Slots.new(number) }

    context "When there are few slots available" do
      subject(:closest_available_slot) do
        slots.list[1] = 2
        slots.list[2] = 4
        slots.closest_available_slot
      end
      it "Should return an object of slots" do
        expect(closest_available_slot).to eq(3)
      end
    end

    context "When there are no slots available" do
      subject(:closest_available_slot) do
        number.times do |n|
         slots.list[n+1] = n + 1
        end
        slots.closest_available_slot
      end
      it "Should return an object of slots" do
        expect(closest_available_slot).to be_nil
      end
    end

  end

end
