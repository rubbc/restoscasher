class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
