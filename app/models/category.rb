class Category < ActiveRecord::Base
    has_and_belongs_to_many :book
    
    validates :name, :description , presence: true
    validates :name, uniqueness: { case_sensitive: false }
    #chỉnh sửa
    def self.search(search)
       where("name LIKE ?", "%#{search}%")
    end
    #----
    before_validation :strip_whitespace, :only => [:name]
    def strip_whitespace
        self.name = self.name.strip unless self.name.nil?
    end
end
