class UpdateUserNames < ActiveRecord::Migration
  def change
    remove_column :users, :name
    add_column :users, :first_name, :string
    add_column :users, :second_name, :string
  end
end
