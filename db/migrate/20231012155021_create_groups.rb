class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :leader
      t.string :description
      t.integer :city
      t.integer :members_number

      t.timestamps
    end
  end
end
