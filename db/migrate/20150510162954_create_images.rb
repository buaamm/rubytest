class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.string :description
      t.references :album, index: true

      t.timestamps null: false
    end
    add_foreign_key :images, :albums
  end
end
