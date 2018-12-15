require 'rails_helper'

RSpec.describe Ticket, type: :model do
  before(:each) do
    Ticket.destroy_all
    %w{one two three four}.each do |w|
      Ticket.create! title: w
    end
  end

  context "tickets" do
    it has four open tickets when none are closed" do
      expect(Ticket.count).to eq(4)
    end

    it "has three open tickets and one closed if one is closed" do
      f = Ticket.first
      f.closed_at = Time.now
      f.save
      expect(Ticket.count).to eq(4)
      expect(Ticket.open_items.count).to eq(3)
      expect(Ticket.open_items.count).not_to eq(4)
    end

    it "formats ticket open and total text correctly" do
      f = Ticket.first
      f.closed_at = Time.now
      f.save

      expect("There are #{Ticket.open_items.count} open issues of #{Ticket.count}").to eq(
        "There are 3 open issues of 4"
      )
    end
  end
end
