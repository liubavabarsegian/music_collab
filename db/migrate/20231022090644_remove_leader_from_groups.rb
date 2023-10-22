class RemoveLeaderFromGroups < ActiveRecord::Migration[7.0]
  def change
    remove_column :groups, :leader
  end
end
