module SoundsFetch
  module Search
    # 検索条件を作成する
    class Conditioner
      attr_reader :text, :instrument_type

      def initialize(search_query)
        @search_query = search_query
        
        set_condition
      end

      private

      def set_condition
        if @search_query['text'].present?
          @text = @search_query['text']
        end

        if @search_query['instrument_type'].present?
          @instrument_type = @search_query['instrument_type'].split(',')
        end
      end
    end
  end
end
