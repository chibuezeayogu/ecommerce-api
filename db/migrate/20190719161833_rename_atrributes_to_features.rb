class RenameAtrributesToFeatures < ActiveRecord::Migration[5.2]
  def change
    rename_column :shopping_cart, :attributes, :features
  end
end
