class AddGeographicValuesToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :country_id, :integer
    add_column :groups, :region_id, :integer
    add_column :groups, :city_id, :integer
  end
end
