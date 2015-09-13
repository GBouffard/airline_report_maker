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

  xit 'knows and calculates the total number of passengers' do
  end

  xit 'knows and calculates the number of general passengers' do
  end

  xit 'knows and calculates the number of airline passengers' do
  end

  xit 'knows and calculates the number of loyalty passengers' do
  end

  xit 'knows and calculates the total of loyalty points redeemded' do
  end

  xit 'knows and calculates the total cost of a flight' do
  end

  xit 'knows and calculates the total unadjusted tickets revenue' do
  end

  xit 'knows and calculates the total adjusted revenue' do
  end

  xit 'knows and informs if a flight can proceed' do
  end

  xit 'writes what is expected as the report in the output file' do
  end
end
