class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums, :force => true do |t|
      t.timestamps
      t.string :title
      t.text :perex
      t.integer :topics_count, :null => false, :default => 0
    end
  end

  def self.down
    drop_table :forums
  end
end