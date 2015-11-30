class AddWineAssociationToSupplier < ActiveRecord::Migration
  def self.up
    add_column :wines, :supplier_id, :integer
    add_index 'wines', ['supplier_id'], :name => 'index_supplier_id'
  end

  def self.down
    remove_column :wines, :supplier_id
  end

end
