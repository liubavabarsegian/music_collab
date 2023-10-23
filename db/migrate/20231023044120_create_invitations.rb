class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.integer :musician_id
      t.integer :group_id
      t.string :token

      t.timestamps
    end
  end
end
