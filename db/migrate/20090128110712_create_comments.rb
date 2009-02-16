class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :force => true do |t|
      t.timestamps
      t.integer :user_id
      t.integer :commentary_id
      t.string :commentary_type
      t.string :title
      t.text :comment
    end
    add_index :comments, :user_id
    add_index :comments, [:commentary_id, :commentary_type]
  end

  def self.down
    drop_table :comments
  end
end
