class User < ActiveRecord::Base
  has_many :comments
  has_many :posts, through: :comments

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
end
