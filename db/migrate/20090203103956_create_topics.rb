class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics, :force => true do |t|
      t.timestamps
      t.integer :forum_id
      t.integer :user_id
      t.string :title
      t.integer :posts_count, :null => false, :default => 0
    end
    add_index :topics, :forum_id
    add_index :topics, :user_id
  end

  def self.down
    drop_table :topics
  end
end