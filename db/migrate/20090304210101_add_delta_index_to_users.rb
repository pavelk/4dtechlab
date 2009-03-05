class AddDeltaIndexToUsers < ActiveRecord::Migration
  def self.up
     add_column :users, :delta, :boolean, :null => false, :default => false 
  end

  def self.down
    remove_column :users, :delta
  end
end
