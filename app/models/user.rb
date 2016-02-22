class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  has_many :microposts
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  ##フォローしているユーザーはたくさんある
  
  ##こっからお気に入り機能
  has_many :like_likerelationships, class_name: "Likerelationship",
                                foreign_key: "like_id",
                                dependent: :destroy
  has_many :like_posts, through: :like_likerelationships, source: :liked
  
  
  
   # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end
   # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
    ##binding.pry
  end

  # ある投稿をライクしているかどうか？
  def like?(micropost)
    like_posts.include?(micropost)
    ##binding.pry
  end
  
   # 投稿をライクする
  def like(micropost)
    likerelationships.find_or_create_by(micropost)
  end

  # ライクしている投稿をアンライクする
  def unlike(micropost)
    like_likerelationship = like_likerelationships.find_by(micropost)
    like_likerelationship.destroy if like_likerelationship
  end

 
  
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
  
end