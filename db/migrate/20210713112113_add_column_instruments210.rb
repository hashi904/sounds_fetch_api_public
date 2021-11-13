class AddColumnInstruments210 < ActiveRecord::Migration[6.1]
  def change
    add_reference :instruments, :instrument_type, foreign_key: true
  end
end
