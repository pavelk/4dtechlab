class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects, :force => true do |t|
      t.timestamps
      t.integer :user_id
      t.string :title, :null => false
      t.string :perex, :null => false
      t.string :link
      t.text :description
      t.boolean :approved, :default => false, :null => false
    end
    add_index :projects, :user_id
  end

  def self.down
    drop_table :projects
  end
end
