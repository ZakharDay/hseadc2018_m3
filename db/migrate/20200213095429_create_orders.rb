class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :cart_id
      t.string :status, default: 'created'

      t.timestamps
    end
  end
end
