class Addcopytoquestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :solved, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :questions, :solved
  end
end
