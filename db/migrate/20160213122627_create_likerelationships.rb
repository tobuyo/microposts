class CreateLikerelationships < ActiveRecord::Migration
  def change
    create_table :likerelationships do |t|
      t.references :like, index: true
      t.references :liked, index: true

      t.timestamps null: false
      
      t.index [:like_id, :liked_id], unique: true 
    end
  end
end
