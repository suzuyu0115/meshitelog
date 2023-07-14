class AddAuthorIdToPosts < ActiveRecord::Migration[7.0]
  def up
    add_reference :posts, :author, null: true, foreign_key: { to_table: :users }
    Post.update_all(author_id: User.first.id)
    change_column_null :posts, :author_id, false
  end
end
