class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|

      t.timestamps null: false
    end
  end
end
