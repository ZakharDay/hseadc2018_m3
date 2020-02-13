class CreateColorsProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :colors_products do |t|
      t.integer :color_id
      t.integer :product_id
    end
  end
end
