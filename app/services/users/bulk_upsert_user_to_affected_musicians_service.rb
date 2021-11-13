module Users
  class BulkUpsertUserToAffectedMusiciansService
    def initialize(user_id, affected_musicians, errors)
      @user_id = user_id
      @affected_musicians = affected_musicians
      @errors = errors
    end

    def call
      affected_musician_attributes = build_attributes
      raise ActiveRecord::RecordNotSaved if @errors.present?

      return if affected_musician_attributes.blank?
      UserToAffectedMusician.insert_all!(affected_musician_attributes)
    end

    private

    def build_attributes
      return if @affected_musicians.blank?

      @affected_musicians.map do |affected_musician|
        affected_musician_attribute = params(affected_musician)
        id = affected_musician[:id] || nil

        affected_musician_attribute.store(:id, id) if updatable_record_present?(id)
        validate_affected_musician(affected_musician_attribute)
        affected_musician_attribute
      end
    end

    def updatable_record_present?(id)
      id.present? &&
      UserToAffectedMusician.where(id: id)
                            .where(user_id: @user_id)
                            .present?
    end

    def params(affected_musician)
      {
        user_id: @user_id,
        affected_musician_id: affected_musician[:musician_id],
        position: affected_musician[:position],
        created_at: Time.now,
        updated_at: Time.now
      }
    end

    def validate_affected_musician(attribute)
      model = UserToAffectedMusician.new(attribute)
      if !model.valid?
        @errors.add(:base, model.errors.messages)
      end

      @errors
    end
  end
end
