class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :wine, index: true, foreign_key: true
      t.belongs_to :basket, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
