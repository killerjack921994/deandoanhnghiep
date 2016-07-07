class Staff < ActiveRecord::Base
    has_many :book, dependent: :nullify
    has_many :comment, dependent: :nullify
    has_many :order
    
    before_save { self.email = email.downcase }
    validates :user, :name, presence: true, length: { maximum: 50 }
    validates :user, uniqueness: { case_sensitive: false }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    has_secure_password
    validate :birthday_cannot_in_the_future
    validates :birthday, presence: true
    /validates :password, presence: true, length: { minimum: 6 }*/
    
    def birthday_cannot_in_the_future
        if birthday.present? && birthday > Date.today
            errors.add(:birthday, I18n.t('.birthday-error'))
        end
    end
     #chỉnh sửa
    def self.search_name(search_name)
       where("name LIKE ?", "%#{search_name}%")
    end
    
    def self.search_email(search_email)
       where("email LIKE ?", "%#{search_email}%")
    end
    #----
end
