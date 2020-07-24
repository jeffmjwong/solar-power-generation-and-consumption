require './src/csv_data_processor'

RSpec.describe CsvDataProcessor do
  describe '.process' do
    let(:solar_generation_data) do
      csv_content = <<~ROWS
        time,power_real,house_id
        00:00:00,120,1
        00:00:00,30,2
        00:05:00,60,1
        00:05:00,90,2
      ROWS

      CSV.new(csv_content, headers: true)
    end

    let(:energy_consumption_data) do
      csv_content = <<~ROWS
        period,usage
        00:00:00,10
        00:30:00,8
      ROWS

      CSV.new(csv_content, headers: true)
    end

    let(:household_information) do
      csv_content = <<~ROWS
        house_id,number_of_occupants,cost_per_kilowatt_hour
        1,2,$0.5
        2,3,$1.0
      ROWS

      CSV.new(csv_content, headers: true)
    end

    let(:energy_data_in_csv_format) do
      {
        solar_generation_data: solar_generation_data,
        energy_consumption_data: energy_consumption_data,
        household_information: household_information
      }
    end

    it 'processes energy data in CSV object format and returns energy data by household id as a hash' do
      expected_result = {
        '1' => {
          energy_generated_in_watt_hours: 15.0,
          energy_consumed_in_kilowatt_hours: 18.0,
          average_cost_per_person: 4.5
        },
        '2' => {
          energy_generated_in_watt_hours: 10.0,
          energy_consumed_in_kilowatt_hours: 18.0,
          average_cost_per_person: 6.0
        }
      }

      actual_result = CsvDataProcessor.process(energy_data_in_csv_format)

      expect(actual_result).to eq(expected_result)
    end
  end
end
