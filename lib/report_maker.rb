class ReportMaker
  from_file, to_file = ARGV
  attr_reader :total_passenger_count,
              :general_passenger_count,
              :airline_passenger_count,
              :loyalty_passenger_count,
              :total_number_of_bags,
              :total_loyalty_points_redeemed,
              :cost_of_flight,
              :total_unadjusted_ticket_revenue,
              :total_adjusted_revenue,
              :can_flight_proceed

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
    cost_calculator
    revenues_calculator
    flight_authorisation
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

  def cost_calculator
    cost_per_passenger = open(@input_file, &:readline).split[4].to_i
    @cost_of_flight = @total_passenger_count * cost_per_passenger
  end

  def revenues_calculator
    @total_unadjusted_ticket_revenue = @total_passenger_count * @ticket_price
    @total_adjusted_revenue = @total_unadjusted_ticket_revenue - @airline_passenger_count * @ticket_price - @total_loyalty_points_redeemed
  end

  def flight_authorisation
    @minimum_takeof_load_percentage = open(@input_file, &:readline).split.last.to_i
    @number_of_seats = IO.readlines(@input_file)[1].split.last.to_i
    conditions_for_authorisation
  end

  def conditions_for_authorisation
    condition1 = (@total_adjusted_revenue > @cost_of_flight)
    condition2 = (@total_passenger_count <= @number_of_seats)
    condition3 = ((@total_passenger_count.to_f / @number_of_seats.to_f) * 100) >= @minimum_takeof_load_percentage
    @can_flight_proceed = (condition1 && condition2 && condition3 ? 'TRUE' : 'FALSE')
  end
end
