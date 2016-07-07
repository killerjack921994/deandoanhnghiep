class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name, unique: true
      t.date :birthday
      t.text :description
      t.string :homeland

      t.timestamps null: false
    end
  end
end
