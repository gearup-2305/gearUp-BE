class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :details
      t.string :image_url
      t.float :requested_amount
      t.integer :category
      t.float :current_amount
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
