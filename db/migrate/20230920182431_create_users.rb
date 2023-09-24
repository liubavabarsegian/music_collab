class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.datetime :birthday
      t.string :phone
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end