class AddColumnLineUserIdToUsersRemoveProviderUid < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :line_user_id, :string

    remove_index :users, name: "index_users_on_provider_and_uid"
    remove_column :users, :provider
    remove_column :users, :uid
  end

  def down
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    change_column_null :users, :provider, false
    change_column_null :users, :uid, false
    add_index :users, ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true

    remove_column :users, :line_user_id
  end
end

