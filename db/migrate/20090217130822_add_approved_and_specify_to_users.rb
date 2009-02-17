class AddApprovedAndSpecifyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :approved, :boolean, :null => false, :default => false
    add_column :users, :specify, :text
  end

  def self.down
    remove_column :users, :solved
    remove_column :users, :specify
  end
end