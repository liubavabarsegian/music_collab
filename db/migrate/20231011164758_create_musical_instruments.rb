class CreateMusicalInstruments < ActiveRecord::Migration[7.0]
  def change
    create_table :musical_instruments do |t|
      t.string :name

      t.timestamps
    end
  end
end
