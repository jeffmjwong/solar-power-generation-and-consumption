require './src/main'

RSpec.describe Main do
  describe '#run' do
    let(:current_directory) { File.dirname(__FILE__) }

    let(:solar_generation_file_path) { '../data/01-solar_generation.csv' }
    let(:energy_consumption_file_path) { '../data/02-consumption.csv' }
    let(:household_information_file_path) { '../data/03-household_information.csv' }

    let(:file_paths) do
      {
        solar_generation: File.join(current_directory, solar_generation_file_path),
        energy_consumption: File.join(current_directory, energy_consumption_file_path),
        household_information: File.join(current_directory, household_information_file_path)
      }
    end

    it 'runs the main program and output the desired results' do
      expected_result = <<~TEXT
        House 1 generated 202083Wh of electricity
        House 1 consumed 145140Wh of electricity

        House 2 generated 200308Wh of electricity
        House 2 consumed 145140Wh of electricity

        House 3 generated 201194Wh of electricity
        House 3 consumed 145140Wh of electricity

        House id: 1 averaged $12.09 per person
        House id: 2 averaged $26.85 per person
        House id: 3 averaged $5.44 per person
      TEXT

      actual_result = Main.new(file_paths, CsvFileParser, CsvDataProcessor, ReportGenerator).run

      expect(actual_result).to eq(expected_result)
    end

    it 'display relevant error message if one of the csv files is not found' do
      invalid_household_information_file_path = '../data/03-invalid_household_information.csv'

      invalid_file_paths = file_paths.merge(
        household_information: File.join(current_directory, invalid_household_information_file_path)
      )

      error_message = Main.new(invalid_file_paths, CsvFileParser, CsvDataProcessor, ReportGenerator).run

      expect(error_message).to include('No such file or directory')
      expect(error_message).to include('../data/03-invalid_household_information.csv')
    end
  end
end
