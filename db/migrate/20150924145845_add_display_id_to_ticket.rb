class AddDisplayIdToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :display_id, :string, limit: 17

    add_index :tickets, [:display_id], unique: true
  end
end
