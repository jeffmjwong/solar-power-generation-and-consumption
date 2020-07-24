class CsvDataProcessor
  attr_reader :solar_generation_data,
              :energy_consumption_data,
              :household_information,
              :solar_generation_block_hours

  def self.process(data)
    new(data).process
  end

  def initialize(data)
    @solar_generation_data = data[:solar_generation_data]
    @energy_consumption_data = data[:energy_consumption_data]
    @household_information = data[:household_information]

    solar_generation_block_minutes = 5.0
    @solar_generation_block_hours = solar_generation_block_minutes / 60.0
  end

  def process
    household_information.each_with_object({}) do |row, result|
      household_id = row['house_id']
      number_of_occupants = row['number_of_occupants'].to_f
      cost_per_kilowatt_hour = row['cost_per_kilowatt_hour'].gsub('$', '').to_f

      result[household_id] = {
        energy_generated_in_watt_hours: total_energy_generated_by_household_id[household_id],
        energy_consumed_in_kilowatt_hours: total_energy_consumed_in_kilowatt_hours,
        average_cost_per_person: total_energy_consumed_in_kilowatt_hours * cost_per_kilowatt_hour / number_of_occupants
      }
    end
  end

  private

  def total_energy_generated_by_household_id
    @total_energy_generated_by_household_id ||=
      solar_generation_data.each_with_object({}) do |row, result|
        power_output = row['power_real'].to_f

        next if power_output <= 0.0

        household_id = row['house_id']

        result[household_id] =
          result[household_id].to_f + (power_output * solar_generation_block_hours)
      end
  end

  def total_energy_consumed_in_kilowatt_hours
    @total_energy_consumed_in_kilowatt_hours ||=
      energy_consumption_data.reduce(0) do |total, row|
        total + row['usage'].to_f
      end
  end
end
