class IncreasePasswordDigetLength < ActiveRecord::Migration[5.2]
  def up
    change_column :customer, :password_digest, :string, limit: 100
  end

  def down
    change_column :customer, :password_digest, :string, limit: 50
  end
end
