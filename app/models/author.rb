class Author < ActiveRecord::Base
    has_many :book, dependent: :nullify
    
    validates :name, :birthday, :description, presence:true
    validates :name, uniqueness: { case_sensitive: false }
    validate :birthday_cannot_in_the_future
    #chỉnh sửa
    def self.search(search)
       where("name LIKE ?", "%#{search}%")
    end
    #----
    def birthday_cannot_in_the_future
        if birthday.present? && birthday > Date.today
            errors.add(:birthday, I18n.t('.birthday-error'))
        end
    end
    
    before_validation :strip_whitespace, :only => [:name]
    def strip_whitespace
        self.name = self.name.strip unless self.name.nil?
    end
end
