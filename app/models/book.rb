class Book < ActiveRecord::Base
    belongs_to :staff
    belongs_to :author
    belongs_to :manufacturer
    has_and_belongs_to_many :category
    has_many :comment
    
    has_many :line_items
    before_destroy :ensure_not_referenced_by_any_line_item
    has_many :order, through: :line_items
    
    validates :name, :description, :price, :image, presence: true
    validates :name, uniqueness: { case_sensitive: false }
    validates :image_url, allow_blank: true, format: {
        with: %r{\.(gif|jpg|png)\Z}i,
        message: 'must be a URL for GIF, JPG or PNG image.'
        }
    attr_accessor :image
    mount_uploader :image, ImageUploader
    #them attr_accessor :image,  mount_uploader :image, ImageUploader
    
    before_validation :strip_whitespace, :only => [:name]
    def strip_whitespace
        self.name = self.name.strip unless self.name.nil?
    end
    
    #chỉnh sửa
    def self.search(search)
       where("name LIKE ?", "%#{search}%")
    end
    #----
    
    def self.search_category(id)
        boo = self.all
        if name.present?
            cat = Category.find(id)
            boo = cat.book
            return boo;
        end
    end
    
    def self.search_author(id)
        cat = self.all
        if name.present?
            cat = cat.where("author_id LIKE ?", id)
            return cat;
        end
    end
    
    def self.search_staff(id)
        cat = self.all
        if name.present?
            cat = cat.where("staff_id LIKE ?", id)
            return cat;
        end
    end
    
    def ensure_not_referenced_by_any_line_item
        if line_items.empty?
            return true
        else
            errors.add(:base, 'Line Items present')
            return false
        end
    end
    
   
end
