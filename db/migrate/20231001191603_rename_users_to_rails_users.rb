class RenameUsersToRailsUsers < ActiveRecord::Migration[7.0]
  def change
    rename_table :users, :rails_users

    remove_foreign_key :listings, :users
    add_foreign_key :listings, :rails_users, column: :user_id
  end
end
