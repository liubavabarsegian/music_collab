class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.integer :group_id
      t.integer :musician_id
      t.string :status
      t.integer :instrument_id

      t.timestamps
    end
  end
end
