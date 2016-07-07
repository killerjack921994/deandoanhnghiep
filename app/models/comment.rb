class Comment < ActiveRecord::Base
    belongs_to :book
    belongs_to :staff
    
    validates :name, :comment, presence: true
     #chỉnh sửa
    def self.search(search)
       where("name LIKE ?", "%#{search}%")
    end
    #----
    def self.search_book(id)
        cat = self.all
        if name.present?
            cat = cat.where("book_id LIKE ?", id)
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
