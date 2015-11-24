class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :name
      t.text :description
      t.string :short_description
      t.string :country_of_origin
      t.string :grape_type
      t.boolean :vegetarian
      t.decimal :price
      t.string :supplier_company
      t.string :pic_url

      t.timestamps null: false
    end
  end
end
