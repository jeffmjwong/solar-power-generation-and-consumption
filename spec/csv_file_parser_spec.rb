require './src/csv_file_parser'

RSpec.describe 'CsvFileParser' do
  describe 'read' do
    it 'reads a CSV file and returns a CSV object' do
      csv_object = CsvFileParser.read(File.join(File.dirname(__FILE__), '../data/01-solar_generation.csv'))
      expect(csv_object).to be_instance_of(CSV)
    end
  end
end
