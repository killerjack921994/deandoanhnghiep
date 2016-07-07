class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name, unique: true
      t.text :description
      t.decimal :price
      t.string :image_url

      t.timestamps null: false
    end
  end
end
