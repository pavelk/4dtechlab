class CreateLibraries < ActiveRecord::Migration
  def self.up
    create_table :libraries, :force => true do |t|
      t.string  :title
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.timestamps
    end
  end

  def self.down
    drop_table :libraries
  end
end
