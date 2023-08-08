class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :address
      t.string :image_url
      t.decimal :price
      t.boolean :buy_or_rent
      t.string :description

      t.timestamps
    end
  end
end
