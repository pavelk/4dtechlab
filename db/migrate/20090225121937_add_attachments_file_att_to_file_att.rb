class AddAttachmentsFileAttToFileAtt < ActiveRecord::Migration
  def self.up
    add_column :file_atts, :file_att_file_name, :string
    add_column :file_atts, :file_att_content_type, :string
    add_column :file_atts, :file_att_file_size, :integer
    add_column :file_atts, :file_att_updated_at, :datetime
  end

  def self.down
    remove_column :file_atts, :file_att_file_name
    remove_column :file_atts, :file_att_content_type
    remove_column :file_atts, :file_att_file_size
    remove_column :file_atts, :file_att_updated_at
  end
end
