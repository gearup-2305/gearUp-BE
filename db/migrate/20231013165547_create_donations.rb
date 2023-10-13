class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations do |t|
      t.string :name
      t.string :email
      t.float :amount
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
