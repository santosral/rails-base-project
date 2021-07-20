class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.string :food_name
      t.string :food_key
      t.string :food_group
      t.integer :user_id
      t.integer :comment_id
      t.string :caption
      t.string :recipe_url
      t.string :image
      t.string :authenticity_token
      t.timestamps
    end
  end
end
