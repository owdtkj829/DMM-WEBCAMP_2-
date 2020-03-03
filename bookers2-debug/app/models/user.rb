class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  validates :name,uniqueness: { case_sensitive: :false },
    		length: { minimum: 2, maximum: 20 }
  validates :introduction,length:{maximum:50}
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image

end
