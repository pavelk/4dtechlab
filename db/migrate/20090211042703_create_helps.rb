class CreateHelps < ActiveRecord::Migration
  def self.up
    create_table :helps, :force => true do |t|
      t.timestamps
      t.string :title, :null => false
      t.string :perex, :null => false
      t.text :description
      t.integer :hits, :null => false, :default => 0
    end
  end

  def self.down
    drop_table :helps
  end
end
