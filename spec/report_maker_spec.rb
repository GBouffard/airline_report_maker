require 'report_maker'

describe ReportMaker do
  describe 'checks files validation' do
    it 'requires 2 files to be given to work' do
      expect { ReportMaker.new } .to raise_error
    end

    it 'can only process a valid input file, meaning with 1 route and 1 aircraft' do
      # for simplicity reasons, we will assume a file is not valid when it does not include a route
      # and an aircraft. There are many more tests that would need to be done to check the accuracy
      # of each line, with arguments counts and nature of each argument (numeric/boolean/string).
      invalid = 'not_a_valid_flight_file.txt'
      expect { ReportMaker.new(invalid, 'file2') } .to raise_error('This file is not valid')
    end
  end

  describe 'with a correct flight file as input' do
    let(:flight1) { 'flight1.txt' }
    let(:flight2) { 'flight2.txt' }
    let(:rm1) { ReportMaker.new(flight1, 'report1.txt') }
    let(:rm2) { ReportMaker.new(flight2, 'report2.txt') }

    # we will test with both example files to make sure it all works.
    # for simplicity and as the 2 examples suggest, we will assume that
    # the first line always refer to the route and second to the aircraft
    it 'knows and calculates the total number of passengers' do
      expect(rm1.total_passenger_count).to eq(8)
      expect(rm2.total_passenger_count).to eq(6)
    end

    it 'knows and calculates the number of general passengers' do
      expect(rm1.general_passenger_count).to eq(4)
      expect(rm2.general_passenger_count).to eq(5)
    end

    it 'knows and calculates the number of airline passengers' do
      expect(rm1.airline_passenger_count).to eq(1)
      expect(rm2.airline_passenger_count).to eq(1)
    end

    it 'knows and calculates the number of loyalty passengers' do
      expect(rm1.loyalty_passenger_count).to eq(3)
      expect(rm2.loyalty_passenger_count).to eq(0)
    end

    it 'knows and calculates the total number of bags' do
      expect(rm1.total_number_of_bags).to eq(9)
      expect(rm2.total_number_of_bags).to eq(6)
    end

    it 'knows and calculates the total of loyalty points redeemded' do
      expect(rm1.total_loyalty_points_redeemed).to eq(40)
      expect(rm2.total_loyalty_points_redeemed).to eq(0)
    end

    it 'knows and calculates the total cost of a flight' do
      expect(rm1.cost_of_flight).to eq(800)
      expect(rm2.cost_of_flight).to eq(600)
    end

    it 'knows and calculates the total unadjusted tickets revenue' do
      expect(rm1.total_unadjusted_ticket_revenue).to eq(1200)
      expect(rm2.total_unadjusted_ticket_revenue).to eq(900)
    end

    it 'knows and calculates the total adjusted revenue' do
      expect(rm1.total_adjusted_revenue).to eq(1010)
      expect(rm2.total_adjusted_revenue).to eq(750)
    end

    it 'knows and informs if a flight can proceed' do
      expect(rm1.can_flight_proceed).to eq('TRUE')
      expect(rm2.can_flight_proceed).to eq('FALSE')
    end

    it 'writes what is expected as the report in the output file' do
      expect(rm1.report_file).to eq('8 4 1 3 9 40 800 1200 1010 TRUE')
      expect(rm2.report_file).to eq('6 5 1 0 6 0 600 900 750 FALSE')
    end
  end
end
