class InstrumentPresenter
  def initialize(instruments)
    @instruments = instruments
  end

  def as_json
    {
      instrument_types: instrument_types(@instruments)
    }
  end

  private

  def instrument_types(instrument)
    @instruments.map do |instrument|
      InstrumentType.by_id(instrument.instrument_type_id)
                    .pluck(:name)
                    .first
    end
  end
end
