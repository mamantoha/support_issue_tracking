class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name,    null: false, default: ""
      t.string :subject, null: false, default: ""
      t.text :body,      null: false, default: ""
      t.string :email,   null: false, default: ""

      t.timestamps null: false
    end
  end
end
