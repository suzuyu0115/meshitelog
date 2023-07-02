class AddFoodImageToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :food_image, :string
  end
end
