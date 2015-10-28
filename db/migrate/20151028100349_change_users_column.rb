class ChangeUsersColumn < ActiveRecord::Migration
  def change
    change_column(:users, :family_name, :string, :null => false)
    change_column(:users, :first_name, :string, :null => false)
    change_column(:users, :admin, :boolean, :null => false, :default => false)
  end
end
