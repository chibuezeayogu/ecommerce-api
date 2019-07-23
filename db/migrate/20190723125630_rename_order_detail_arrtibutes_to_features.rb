class RenameOrderDetailArrtibutesToFeatures < ActiveRecord::Migration[5.2]
  def change
    rename_column :order_detail, :attributes, :features
  end
end
