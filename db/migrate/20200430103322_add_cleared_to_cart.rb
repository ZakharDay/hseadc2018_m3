class AddClearedToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :cleared, :boolean, default: false
  end
end
