class AddPasswordConfirmationToUsers < ActiveRecord::Migration[7.0]
  def change
    return if column_exists?(:users, :password_confirmation)

    add_column :users, :password_confirmation, :string
  end
end
