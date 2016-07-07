class AddStaffToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :staff, index: true
    add_foreign_key :comments, :staff
  end
end
