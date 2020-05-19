class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  
  has_many :posts
  has_many :comments
  has_many :active_relationships, class_name:"Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :from_messages, class_name:"Message", foreign_key:"from_id", dependent: :destroy
  has_many :to_messages, class_name:"Message", foreign_key:"to_id", dependent: :destroy
  has_many :sent_messages, through: :from_messages, source: :from
  has_many :received_message, through: :to_messages, source: :to

  
  def feed
  end
  
  def follow(other_user)
    following << other_user
  end
  
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user)
    following.include?(other_user)
  end
  
  def send_message(other_user, room_id, content)
    from_messages.create!(to_id: other_user.id, room_id: room_id, content: content)
  end
  
  has_secure_password
  
  def posts
    return Post.where(user_id: self.id)
  end
  
end
