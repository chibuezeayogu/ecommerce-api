class AllowNullColumn < ActiveRecord::Migration[5.2]
  def up
    change_column :shopping_cart, :added_on, :datetime, null: true
    change_column :shopping_cart, :buy_now, :boolean, default: false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end

  def down
    change_column :shopping_cart, :added_on, :datetime, null: false
    change_column :shopping_cart, :buy_now, :boolean, default: true
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
