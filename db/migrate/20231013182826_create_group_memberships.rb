class CreateGroupMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :group_memberships do |t|
      t.integer :group_id
      t.integer :musician_id
      t.integer :instrument_id

      t.timestamps
    end
  end
end
