class RemoveInstrumentFromLiveExperince < ActiveRecord::Migration[6.1]
  def change
    remove_column :instruments, :live_experience
  end
end
