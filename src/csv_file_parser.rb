require 'csv'

class CsvFileParser
  def self.read(file_path)
    CSV.new(File.read(file_path), headers: true)
  end
end
