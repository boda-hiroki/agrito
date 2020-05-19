class Post < ApplicationRecord
  validates :content, {presence: true}
  validates :user_id, {presence: true}
  
  belongs_to :user
  has_many :comments
  
  def user
    return User.find_by(id: self.user_id)
  end
  
  def comments
    return Comment.where(post_id: self.id)
  end
end
