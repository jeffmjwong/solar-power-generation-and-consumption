require './src/report_generator'

RSpec.describe CsvDataProcessor do
  describe '.generate' do
    let(:energy_data_by_household_id) do
      {
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
    end

    it 'generates properly formatted reports by passing in energy data by household id' do
      expected_result = <<~TEXT
        House id: 1 generated 15Wh of electricity
        House id: 1 consumed 18000Wh of electricity

        House id: 2 generated 10Wh of electricity
        House id: 2 consumed 18000Wh of electricity

        House id: 1 averaged $4.5 per person
        House id: 2 averaged $6.0 per person
      TEXT

      actual_result = ReportGenerator.generate(energy_data_by_household_id)

      expect(actual_result).to eq(expected_result)
    end
  end
end
