class InstrumentsPresenter
  def initialize(instruments)
    @instruments = instruments
  end

  def as_json
    return {} if @instruments.blank?

    @instruments.map do |instrument|
      {
        name: instrument_type(instrument),
        experience: experience(instrument.experience),
        # skill_level: skill_level(instrument.skill_level),
        live_experience: live_experiences(instrument),
        # equipments: equipments(instrument),
        # special_skills: special_skills(instrument),
        position: instrument.position
      }
    end.sort_by! { |val| val[:position] }
  end

  private

  def instrument_type(instrument)
    InstrumentType.by_id(instrument.instrument_type_id)
                  .pluck(:name)
                  .first
  end

  def experience(experience_id)
    Instrument::EXPERIENCE[experience_id]
  end

  def skill_level(skill_level_id)
    Instrument::SKILL_LEVEL[skill_level_id]
  end

  def live_experiences(instrument)
    ids = instrument.instrument_to_live_experiences
                    .pluck(:live_experience_id)

    LiveExperience.by_id(ids).pluck(:type)
  end

  def equipments(instrument)
    ids = instrument.instrument_to_equipments
                    .pluck(:equipment_id)

    Equipment.by_id(ids).pluck(:name)
  end

  def special_skills(instrument)
    ids = instrument.instrument_to_special_skills
                    .pluck(:special_skill_id)

    SpecialSkill.by_id(ids).pluck(:name)
  end
end
