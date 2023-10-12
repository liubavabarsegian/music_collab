class CreateMusicianInstruments < ActiveRecord::Migration[7.0]
  def change
    create_table :musician_instruments do |t|
      t.integer :musician_id
      t.integer :instrument_id

      t.timestamps
    end
  end
end
