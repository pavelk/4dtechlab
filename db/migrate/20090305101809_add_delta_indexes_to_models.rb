class AddDeltaIndexesToModels < ActiveRecord::Migration
  def self.up
    add_column :comments, :delta, :boolean, :null => false, :default => false
    add_column :events, :delta, :boolean, :null => false, :default => false
    add_column :helps, :delta, :boolean, :null => false, :default => false
    add_column :items, :delta, :boolean, :null => false, :default => false
    add_column :posts, :delta, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :comments, :delta
    remove_column :events, :delta
    remove_column :helps, :delta
    remove_column :items, :delta
    remove_column :posts, :delta
  end
end
