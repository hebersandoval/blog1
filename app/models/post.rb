class Post < ActiveRecord::Base
  has_many :comments
  has_many :users, through: :comments

  def post_summary
    self.title + " - " + self.content
  end
end
