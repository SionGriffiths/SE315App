class RemoveSupplierNameFromWines < ActiveRecord::Migration
  def up
    remove_column :wines, :supplier_company
  end

  def down
    add_column :wines, :supplier_company, :string
  end

end
