# 更新画面用の楽器プレゼンター

module Registration
  class UpdateInstrumentsPresenter
    def initialize(instruments)
      @instruments = instruments
    end
    
    def as_json
      return {} if @instruments.blank?

      @instruments.map do |instrument|
        {
          id: instrument.id,
          instrument_type_id: instrument.instrument_type_id,
          experience: instrument.experience,
          skill_level: instrument.skill_level,
          position: instrument.position,
          live_experience: live_experience(instrument)
        }
      end
    end

    private

    def live_experience(instrument)
      instrument_to_live_experiences = instrument.instrument_to_live_experiences

      instrument_to_live_experiences.map do |record|
        {
          id: record.id,
          live_experience_id: record.live_experience_id
        }
      end
    end
  end
end
