class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :name, unique: true
      t.date :birthday
      t.string :gender
      t.string :phone
      t.text :address
      t.string :email, unique: true

      t.timestamps null: false
    end
  end
end
