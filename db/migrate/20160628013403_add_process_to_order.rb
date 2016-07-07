class AddProcessToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :process, :string
  end
end
