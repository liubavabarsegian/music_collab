class AddHasConcertExperienceToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :has_concert_experience, :boolean
  end
end
