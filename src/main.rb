class Main
  attr_reader :file_paths, :parser, :processor, :report_generator

  def initialize(file_paths, parser, processor, report_generator)
    @file_paths = file_paths
    @parser = parser
    @processor = processor
    @report_generator = report_generator
  end

  def run
    energy_data_summary_by_household_id = processor.process(
      solar_generation_data: read(file_paths[:solar_generation]),
      energy_consumption_data: read(file_paths[:energy_consumption]),
      household_information: read(file_paths[:household_information])
    )

    report_generator.generate(energy_data_summary_by_household_id)
  rescue Errno::ENOENT => e # for file not found exceptions
    e.message
  end

  private

  def read(file_path)
    parser.read(file_path)
  end
end
