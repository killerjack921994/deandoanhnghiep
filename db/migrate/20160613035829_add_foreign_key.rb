class AddForeignKey < ActiveRecord::Migration
  def change
    add_reference :books, :staff, index: true
    add_foreign_key :books, :staff
    
    add_reference :books, :author, index: true
    add_foreign_key :books, :author
    
    add_reference :books, :manufacturer, index: true
    add_foreign_key :books, :manufacturer
  end
end
