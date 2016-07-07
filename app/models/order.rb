class Order < ActiveRecord::Base
     has_many :line_items, dependent: :destroy
     has_many :book, through: :line_items
     belongs_to :staff
     
     validates :name, :method, :payment, presence: true, length: { maximum: 50 }
     
     def add_line_items_from_cart(cart)
        cart.line_items.each do |item|
            item.cart_id = nil
            line_items << item
        end
    end
     
     def self.search_method(method)
        cat = self.all
        if name.present?
            cat = cat.where("method LIKE ?", method)
            return cat;
        end
    end
     
     def self.search_payment(payment)
        cat = self.all
        if name.present?
            cat = cat.where("payment LIKE ?", payment)
            return cat;
        end
    end
     
     def self.search_process(process)
        cat = self.all
        if name.present?
            cat = cat.where("process LIKE ?", process)
            return cat;
        end
    end
     
     def self.search_owner(id)
        cat = self.all
        if name.present?
            cat = cat.where("staff_id LIKE ?", id)
            return cat;
        end
    end
end
