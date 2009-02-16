class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions, :force => true do |t|
      t.timestamps
      t.integer :user_id
      t.string :title, :null => false
      t.string :perex, :null => false
      t.text :description
      t.boolean :active, :null => false, :default => false
    end
    add_index :questions, :user_id
  end

  def self.down
    drop_table :questions
  end
end
