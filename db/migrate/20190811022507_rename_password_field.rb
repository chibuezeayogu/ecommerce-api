class RenamePasswordField < ActiveRecord::Migration[5.2]
  def change
    rename_column :customer, :password_digest, :encrypted_password
  end
end
