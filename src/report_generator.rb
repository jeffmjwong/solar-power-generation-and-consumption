class ReportGenerator
  attr_reader :data
  attr_accessor :first_report, :second_report

  def self.generate(data)
    new(data).generate
  end

  def initialize(data)
    @data = data
    @first_report = []
    @second_report = []
  end

  def generate
    data.each do |household_id, summary|
      energy_generated_in_watt_hours = summary[:energy_generated_in_watt_hours].round
      energy_consumed_in_watt_hours = (summary[:energy_consumed_in_kilowatt_hours] * 1000).round
      average_cost_per_person = summary[:average_cost_per_person].round(2)

      first_report << "House #{household_id} generated #{energy_generated_in_watt_hours}Wh of electricity\n"
      first_report << "House #{household_id} consumed #{energy_consumed_in_watt_hours}Wh of electricity\n\n"

      second_report << "House id: #{household_id} averaged $#{average_cost_per_person} per person\n"
    end

    (first_report + second_report).join
  end
end
