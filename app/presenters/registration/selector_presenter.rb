module Registration
  class SelectorPresenter
    def as_json
      {
        music_categories: music_categories,
        sns_services: sns_services,
        instrument_type: instrument_type,
        instrument_experience: instrument_experience,
        instrument_skill_level: instrument_skill_level,
        live_experience: live_experience,
        equipemnts: equipemnts,
        special_skills: special_skills,
        active_dates: active_dates
      }
    end

    private

    def music_categories
      MusicCategory.all.select(:id, :name)
    end

    def sns_services
      UserSnsService::SNS_JSON_DATA
    end

    def instrument_type
      InstrumentType.all.select(:id, :name)
    end

    def instrument_experience
      Instrument::EXPERIENCE_HASH_IN_ARRAY
    end

    def instrument_skill_level
      Instrument::SKILL_LEVEL_HASH_IN_ARRAY
    end

    def live_experience
      LiveExperience.all.select(:id, :type)
    end

    def equipemnts
      Equipment.all.select(:id, :name)
    end

    def special_skills
      SpecialSkill.all.select(:id, :name)
    end

    def active_dates
      UserActiveDate::DATE_IN_HASH
    end
  end
end
