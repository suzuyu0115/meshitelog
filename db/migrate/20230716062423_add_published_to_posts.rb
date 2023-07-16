class AddPublishedToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :published, :boolean, default: false
    Post.update_all(published: true)
    change_column_null :posts, :published, false
  end
end
