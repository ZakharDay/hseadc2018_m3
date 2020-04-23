class AddCoverToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :cover, :string
  end
end
