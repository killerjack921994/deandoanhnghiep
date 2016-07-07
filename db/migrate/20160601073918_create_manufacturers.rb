class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string :name, unique: true
      t.text :address
      t.string :phone
      t.string :fax

      t.timestamps null: false
    end
  end
end
