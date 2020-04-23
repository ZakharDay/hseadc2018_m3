class AddUuidToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :uuid, :string
  end
end
