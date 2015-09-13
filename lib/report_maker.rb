class ReportMaker
  from_file, to_file = ARGV

  def initialize(from_file, to_file)
    @flight_data = open(from_file).read
    file_validation
  end

  def file_validation
    fail 'This file is not valid' unless @flight_data.include?('route' && 'aircraft')
  end
end
