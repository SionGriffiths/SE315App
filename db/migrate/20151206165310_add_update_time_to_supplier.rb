class AddUpdateTimeToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :last_update, :string
  end
end
