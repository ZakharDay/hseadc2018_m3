class AddGuestUuidToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :guest_uuid, :string
  end
end
