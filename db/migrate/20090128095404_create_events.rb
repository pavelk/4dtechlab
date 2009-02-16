class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events, :force => true do |t|
      t.timestamps
      t.integer :user_id
      t.string :title, :null => false
      t.string :perex, :null => false
      t.string :location
      t.string :link
      t.text :description
      t.datetime :event_date
      t.boolean :approved, :default => false, :null => false
    end
    add_index :events, :user_id
    add_index :events, :event_date
  end

  def self.down
    drop_table :events
  end
end
