class CreateFileAtts < ActiveRecord::Migration
  def self.up
    create_table :file_atts do |t|
      t.integer :attachable_id
      t.string :title, :attachable_type
      t.timestamps
    end
    add_index :file_atts, [:attachable_id, :attachable_type]
  end

  def self.down
    drop_table :file_atts
  end
end
