class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer, default: 0
    User.update_all(role: 0)
    change_column_null :users, :role, false
  end
end
