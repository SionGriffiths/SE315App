class RemoveUserFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :user_id
  end
end
