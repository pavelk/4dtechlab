class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :attachable_id
      t.string :title, :attachable_type
      t.timestamps
    end
    add_index :photos, [:attachable_id, :attachable_type]
  end

  def self.down
    drop_table :photos
  end
end
