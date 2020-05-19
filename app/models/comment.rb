class Comment < ApplicationRecord
  validates :content, {presence: true}
  validates :user_id, {presence: true}
  validates :post_id, {presence: true}
  
  belongs_to :user
  belongs_to :post
  
  def user
    return User.find_by(id: self.user_id)
  end
  
  def post
    return Post.find_by(id: self.post_id)
  end
end
