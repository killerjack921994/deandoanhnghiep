class Manufacturer < ActiveRecord::Base
    has_many :book, dependent: :nullify
    
    validates :name, :address, :phone, presence: true
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
