# frozen_string_literal: true

class AddFilesUploadsCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :file_uploads_count, :integer, default: 0
  end
end
