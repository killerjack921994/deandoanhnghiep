class AddUserPasswordToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :user, :string, unique: true
    add_column :staffs, :password_digest, :string
  end
end
