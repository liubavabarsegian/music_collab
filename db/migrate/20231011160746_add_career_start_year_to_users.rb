class AddCareerStartYearToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :career_start_year, :integer
  end
end
