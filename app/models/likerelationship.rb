class Likerelationship < ActiveRecord::Base
  belongs_to :like, class_name: "User"
  belongs_to :liked, class_name: "Micropost"
end
