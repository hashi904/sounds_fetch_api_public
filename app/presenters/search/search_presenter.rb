module Search
  class SearchPresenter
    def as_json
      {
        instrument_types: instrument_types
      }
    end

    private

    def instrument_types
      InstrumentType.all.select(:id, :name).map do |instrument_type|
        {
          id: instrument_type.id,
          name: instrument_type.name
        }
      end
    end
  end
end
