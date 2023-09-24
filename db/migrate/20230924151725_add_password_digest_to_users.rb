class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    return if column_exists?(:users, :password_digest)

    add_column :users, :password_digest, :string
  end
end
