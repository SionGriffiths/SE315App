class AddRouteUrlsToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :all_wines_url, :string
    add_column :suppliers, :new_orders_url, :string
  end
end
