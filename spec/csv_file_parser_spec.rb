require './src/csv_file_parser'

RSpec.describe CsvFileParser do
  describe '.read' do
    let(:current_directory) { File.dirname(__FILE__) }
    let(:solar_generation_file_path) { '../data/01-solar_generation.csv' }

    it 'reads a CSV file and returns a CSV object' do
      csv_object = CsvFileParser.read(File.join(current_directory, solar_generation_file_path))

      expect(csv_object).to be_instance_of(CSV)
    end
  end
end
