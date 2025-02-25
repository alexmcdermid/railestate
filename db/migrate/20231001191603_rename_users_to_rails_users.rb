class RenameUsersToRailsUsers < ActiveRecord::Migration[7.0]
  def change
    if foreign_key_exists?(:listings, :users)
      remove_foreign_key :listings, :users
    end

    rename_table :users, :rails_users

    add_foreign_key :listings, :rails_users, column: :user_id
  end
end
