require './src/csv_file_parser'

RSpec.describe CsvFileParser do
  describe '.read' do
    let(:current_directory) { File.dirname(__FILE__) }

    let(:solar_generation_file_path) { '../data/01-solar_generation.csv' }
    let(:invalid_solar_generation_file_path) { '../data/01-invalid_solar_generation.csv' }

    it 'reads a CSV file and returns a CSV object' do
      csv_object = CsvFileParser.read(File.join(current_directory, solar_generation_file_path))

      expect(csv_object).to be_instance_of(CSV)
    end

    it 'raises Errno::ENOENT error if file is not found' do
      expect do
        CsvFileParser.read(File.join(current_directory, invalid_solar_generation_file_path))
      end.to raise_exception(Errno::ENOENT)
    end
  end
end
