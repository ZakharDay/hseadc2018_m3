class CreateProductItems < ActiveRecord::Migration[6.0]
  def change
    create_table :product_items do |t|
      t.integer :product_id
      t.integer :color_id
      t.string :serial_number
      t.string :status, default: 'available'

      t.timestamps
    end
  end
end
