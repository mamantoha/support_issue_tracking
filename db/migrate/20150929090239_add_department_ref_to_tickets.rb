class AddDepartmentRefToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :department, index: true, foreign_key: true
  end
end
