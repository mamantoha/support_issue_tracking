class AddStatusToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :status, :string

    add_index :tickets, [:status]
  end
end
