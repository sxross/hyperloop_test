class AddTitleToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :title, :string
    add_column :tickets, :priority, :integer
    change_column :tickets, :description, :text
  end
end
