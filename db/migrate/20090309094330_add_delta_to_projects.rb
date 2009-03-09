class AddDeltaToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :delta, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :projects, :delta
  end
end
