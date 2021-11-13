# 楽器関連の中間テーブルにupsertするサービスクラス
module Instruments
  class UpsertJoinTableService
    def initialize(instrument_id, instrument_params, errors, mode = 'create')
      @instrument_id = instrument_id
      @instrument_params = instrument_params
      @errors = errors
      @mode = mode
    end

    def call
      # special_skill_attributes   = build_special_skill_attributes
      # equipment_attributes       = build_equipment_attributes
      live_experience_attributes = build_live_experience_attributes
      raise ActiveRecord::RecordNotSaved if @errors.present?

      # upsert_instrument_to_special_skill(special_skill_attributes)
      # upsert_instrument_to_equipmnet(equipment_attributes)
      upsert_instrument_to_live_experience(live_experience_attributes)
    end

    private

    def upsert_instrument_to_special_skill(special_skill_attributes)
      return if special_skill_attributes.blank?

      InstrumentToSpecialSkill.upsert_all(special_skill_attributes)
    end

    def upsert_instrument_to_equipmnet(equipment_attributes)
      return if equipment_attributes.blank?

      InstrumentToEquipment.upsert_all(equipment_attributes)
    end

    def upsert_instrument_to_live_experience(live_experience_attributes)
      return if live_experience_attributes.blank?

      InstrumentToLiveExperience.upsert_all(live_experience_attributes)
    end

    def build_special_skill_attributes
      return if @instrument_params['special_skills'].blank? && @mode == 'update'

      @instrument_params['special_skills'].map do |special_skill|
        hash = {
                 instrument_id: @instrument_id,
                 special_skill_id: special_skill[:special_skill_id],
                 created_at: Time.now,
                 updated_at: Time.now
               }

        id = special_skill[:id] || nil
        hash.store(:id, id) if updatable_record_present?(id, InstrumentToSpecialSkill)
        validate_attribute(hash, InstrumentToSpecialSkill)

        hash
      end
    end

    def build_equipment_attributes
      return if @instrument_params['equipments'].blank? && @mode == 'update'

      @instrument_params['equipments'].map do |equipment|
        hash = {
                 instrument_id: @instrument_id,
                 equipment_id: equipment[:equipment_id],
                 created_at: Time.now,
                 updated_at: Time.now
               }
        id = equipment[:id] || nil
        hash.store(:id, id) if updatable_record_present?(id, InstrumentToEquipment)
        validate_attribute(hash, InstrumentToEquipment)

        hash
      end
    end

    def build_live_experience_attributes
      return if @instrument_params['live_experiences'].blank? && @mode == 'update'

      @instrument_params['live_experiences'].map do |live_experience|
        hash = {
                 instrument_id: @instrument_id,
                 live_experience_id: live_experience[:live_experience_id],
                 created_at: Time.now,
                 updated_at: Time.now
               }
        id = live_experience[:id] || nil
        hash.store(:id, id) if updatable_record_present?(id, InstrumentToLiveExperience)
        validate_attribute(hash, InstrumentToLiveExperience)

        hash
      end
    end

    def updatable_record_present?(id, model)
      id.present? &&
      model.where(id: id)
           .where(instrument_id: @instrument_id)
           .present?
    end

    def validate_attribute(attribute, model)
      object = model.new(attribute)

      if !object.valid?
        # todo 追加したエラーメッセージが"is invalid"になってしまう
        @errors.add(:base, object.errors.messages)
      end

      @errors
    end
  end
end
