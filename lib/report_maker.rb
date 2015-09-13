class ReportMaker
  from_file, to_file = ARGV
  attr_reader :total_passenger_count,
              :general_passenger_count,
              :airline_passenger_count,
              :loyalty_passenger_count,
              :total_number_of_bags,
              :total_loyalty_points_redeemed

  def initialize(from_file, to_file)
    @input_file = from_file
    @flight_data = open(from_file).read
    file_validation
    calculate
  end

  def file_validation
    fail 'This file is not valid' unless @flight_data.include?('route' && 'aircraft')
  end

  def calculate
    passengers_counters
    bags_counter
    loyalty_points_counter
  end

  def passengers_counters
    @total_passenger_count = @flight_data.each_line.count - 2
    @general_passenger_count = 0
    @flight_data.each_line { |line| @general_passenger_count += 1 if line.include?('general') }
    @airline_passenger_count = 0
    @flight_data.each_line { |line| @airline_passenger_count += 1 if line.include?('airline') }
    @loyalty_passenger_count = 0
    @flight_data.each_line { |line| @loyalty_passenger_count += 1 if line.include?('loyalty') }
  end

  def bags_counter
    @total_number_of_bags = @total_passenger_count
    @flight_data.each_line { |line| @total_number_of_bags += 1 if line.include?('loyalty') && line.split.last == 'TRUE' }
  end

  def loyalty_points_counter
    @total_loyalty_points_redeemed = 0
    @ticket_price = open(@input_file, &:readline).split[5].to_i
    redeem_calculator
  end

  def redeem_calculator
    @flight_data.each_line do |line|
      if line.include?('loyalty') && line.split[5] == 'TRUE'
        @total_loyalty_points_redeemed += (line.split[4].to_i < @ticket_price ? line.split[4].to_i : @ticket_price)
      end
    end
  end
end
