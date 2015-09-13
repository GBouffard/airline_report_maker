class ReportMaker
  from_file, to_file = ARGV
  attr_reader :total_passenger_count

  def initialize(from_file, to_file)
    @flight_data = open(from_file).read
    file_validation
    calculate
  end

  def file_validation
    fail 'This file is not valid' unless @flight_data.include?('route' && 'aircraft')
  end

  def calculate
    @total_passenger_count = @flight_data.each_line.count - 2
  end
end
