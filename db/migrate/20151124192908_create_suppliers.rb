class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :base_rest_url
      t.string :name

      t.timestamps null: false
    end
  end
end
