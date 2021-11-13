module Users
  class BulkInsertUserToMusicCategory
    def initialize(user, params, mode=:create)
      @user = user
      @params = params
      @mode = mode
    end

    def call
      destroy
      bulk_insert
    end

    private

    def destroy
      if @mode == :update
        records = UserToMusicCategory.where(user_id: @user.id)
        records.destroy_all
      end
    end

    def bulk_insert
      UserToMusicCategory.import(attributes)
    end

    def attributes
      @params.map do |v|
        v.merge!({user_id: @user.id})
        v.to_hash
      end
    end
  end
end
