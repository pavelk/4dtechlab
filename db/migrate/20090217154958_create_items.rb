class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items, :force => true do |t|
      t.timestamps
      t.integer :user_id
      t.integer :library_id
      t.string :title, :null => false
      t.string :perex, :null => false
      t.string :link
      t.text :description
      t.datetime :event_date
      t.boolean :approved, :default => false, :null => false
    end
    add_index :items, :user_id
    add_index :items, :library_id
  end

  def self.down
    drop_table :items
  end
end
