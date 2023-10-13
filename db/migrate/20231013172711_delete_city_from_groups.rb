class DeleteCityFromGroups < ActiveRecord::Migration[7.0]
  def change
    remove_column :groups, :city
  end
end
