class Post < ActiveRecord::Base
  has_many :comments
  has_many :users, through: :comments

  validates :title, presence: true
  validates :content, presence: true

  def post_summary
    self.title + " - " + self.content
  end
end
