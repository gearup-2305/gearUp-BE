class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :email
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :password_digest
      t.string :medium
      t.string :profile_image

      t.timestamps
    end
  end
end
