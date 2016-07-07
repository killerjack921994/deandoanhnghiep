class AddPaymentStaffToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :payment, :string
    add_reference :orders, :staff, index: true
    add_foreign_key :orders, :staff
  end
end
