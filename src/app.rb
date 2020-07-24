require_relative 'main'
require_relative 'csv_file_parser'
require_relative 'csv_data_processor'
require_relative 'report_generator'

CURRENT_DIR = File.dirname(__FILE__)

csv_file_paths = {
  solar_generation: File.join(CURRENT_DIR, '../data/01-solar_generation.csv'),
  energy_consumption: File.join(CURRENT_DIR, '../data/02-consumption.csv'),
  household_information: File.join(CURRENT_DIR, '../data/03-household_information.csv')
}

main = Main.new(csv_file_paths, CsvFileParser, CsvDataProcessor, ReportGenerator)
puts main.run
