class AddDeleteAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :string
    add_index :users, :deleted_at
  end
end
