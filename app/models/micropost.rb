class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  
  mount_uploader :image, ImageUploader

  ##こっからお気に入り機能
  has_many :liked_likerelationships, class_name: "Likerelationship",
                                foreign_key: "liked_id",
                                dependent: :destroy
  has_many :liked_users, through: :liked_likerelationships, source: :like
  
  
end
