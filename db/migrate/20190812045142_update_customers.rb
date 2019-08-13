class UpdateCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column(:customer, :provider, :string, limit: 50, null: false, default: '')
    add_column(:customer, :uid, :string, limit: 500, null: false, default: '')
  end
end
