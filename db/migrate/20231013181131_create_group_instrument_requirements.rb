class CreateGroupInstrumentRequirements < ActiveRecord::Migration[7.0]
  def change
    create_table :group_instrument_requirements do |t|
      t.integer :group_id
      t.integer :instrument_id
      t.integer :quantity

      t.timestamps
    end
  end
end
