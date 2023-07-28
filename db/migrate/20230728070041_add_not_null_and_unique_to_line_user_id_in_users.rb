class AddNotNullAndUniqueToLineUserIdInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :line_user_id, false
    add_index :users, :line_user_id, unique: true
  end
end
